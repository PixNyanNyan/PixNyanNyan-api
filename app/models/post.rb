class Post < ApplicationRecord
  include NullifyBlankAttributes

  # image Attachment
  has_attached_file :image, {
    styles: { small: ['125x125>', :jpg], medium: ['250x250>', :jpg], original: '' },
    convert_options: { 
      small: '-quality 80 -interlace Plane -strip',
      medium: '-quality 80 -interlace Plane -strip',
      original: '-strip'
    }
  }
  validates_attachment_content_type :image, content_type: /\Aimage\/(png|gif|jpeg|pjpeg)\z/
  validates_attachment_size :image, in: 0..MAX_IMAGE_KB_SIZE.kilobytes
  serialize :image_dimensions
  before_save :extract_image_dimensions

  # association
  has_many :replies, class_name: 'Post',
    foreign_key: 'parent_post_id', dependent: :destroy
  belongs_to :parent_post, class_name: 'Post', optional: true,
    foreign_key: 'parent_post_id', counter_cache: :reply_count
  has_many :complaints, dependent: :destroy
  belongs_to :admin, optional: true

  # callbacks
  before_create :generate_id_hash
  before_create :parse_tripcode
  before_save :avoid_locked_record
  before_destroy :avoid_locked_record
  after_create_commit -> { broadcast_to_everyone('create') }
  after_update_commit -> { broadcast_to_everyone('update') }
  after_destroy_commit -> { broadcast_to_everyone('destroy') }
  
  # validations
  validates :message, length: { maximum: MAX_POST_MESSAGE_WORDCOUNT }
  validates :title, length: { maximum: 200 }
  validates :author, length: { maximum: 200 }
  validates :email, length: { maximum: 200 }
  validates :client_id, length: { maximum: 128 }
  validates :ip, presence: true
  validates :parent_post, presence: true, if: 'parent_post_id.present?'
  validates :admin, presence: true, if: 'admin_id.present?'
  validate :content_presence

  # scopes
  default_scope { order(id: :asc) }
  scope :recent, -> { reorder(id: :desc) }
  scope :threads, -> { where(parent_post_id: nil) }
  scope :before, -> cursor { where('id < ?', cursor) if cursor.present? }
  scope :after, -> cursor { where('id > ?', cursor) if cursor.present? }
  scope :in_range, -> (lower, upper) { after(lower).before(upper) }
  scope :by_identity_hash, -> keyword { where(identity_hash: keyword) }
  scope :by_tripcode, -> keyword { where(tripcode: keyword) }
  scope :by_client_id, -> keyword { where(client_id: keyword) }
  scope :by_title, -> keyword { where('title @@ ?', keyword) }
  scope :by_author, -> keyword { where('author @@ ?', keyword) }
  scope :by_email, -> keyword { where('email @@ ?', keyword) }
  scope :by_message, -> keyword { where('message @@ ?', keyword) }

  def self.send_chain(methods)
    methods.inject(self) do |chain, scope|
      chain.send(*scope)
    end
  end

  def self.latest_replies(parents, limit)
    return [] unless parents.present?

    parent_ids = parents.map{|p| p.id.to_i }.join(',')
    limit = limit.to_i
    sql = <<-SQL
      select * from posts
      join lateral (
        select * from posts p_inner
        where p_inner.parent_post_id = posts.id
        order by p_inner.id desc
        limit #{limit}
      ) p on true
      where posts.id in (#{parent_ids})
      order by posts.id asc, p.id asc
    SQL

    find_by_sql(sql).group_by{|x| x.parent_post_id}
  end

  def self.gen_passwd(passwd)
    Digest::SHA1.base64digest(passwd)
  end

  def is_admin
    admin_id.present?
  end

  def delete_password=(passwd)
    self[:delete_password] = passwd.blank? ? nil : self.class.gen_passwd(passwd)
  end
  
  protected

  ## Validators

  def content_presence
    if message.blank? && image.blank?
      errors.add(:message, 'Message and Image are both empty')
    end
  end

  ## Callbacks

  def generate_id_hash
    ip = self[:ip]
    date = Time.now.to_date.to_s
    id_hash = Digest::SHA1.base64digest(ip + date + Rails.application.secrets.secret_key_base)
    
    self[:identity_hash] = id_hash[0...8]
  end

  def parse_tripcode
    author = self[:author].to_s
    match = author.match(/\A(.*)#(.*)\z/)
    if match.nil?
      self[:tripcode] = nil
      return
    end

    secret = match[2].force_encoding(Encoding::ASCII_8BIT)
    salt = "#{secret}H."[1..2]
    salt.gsub!(/[^\.-z]/, '.')
    salt.tr!(':-@[-`', 'A-Ga-f')

    self[:author] = match[1]
    self[:tripcode] = secret.crypt(salt)[-10..-1]
  end

  def avoid_locked_record
    if self[:locked] || (parent_post && parent_post.locked)
      raise ActiveRecord::Rollback, "Record locked!"
    end
  end

  def extract_image_dimensions
    return if image_content_type.nil?

    tempfile = image.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self[:image_dimensions] = [geometry.width.to_i, geometry.height.to_i]
    end
  end

  def broadcast_to_everyone(action)
    content = {action: action, obj: ApplicationController.render(json: self)}
    ActionCable.server.broadcast('posts_channel', content)
  end
end
