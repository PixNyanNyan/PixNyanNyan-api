class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :email, :message, :locked, :is_admin
  attributes :identity_hash, :tripcode, :parent_post_id
  attributes :reply_count, :created_at, :updated_at
  attribute(:image){ image_info }
  has_many(:replies){|s| s.reply_finder }

  def image_info
    return nil unless object.image.present?

    {
      dimensions: object.image_dimensions,
      file_name: object.image_file_name,
      file_size: object.image_file_size,
      url_small: object.image.url(:small),
      url_medium: object.image.url(:medium),
      url_orig: object.image.url
    }
  end

  def reply_finder
    replies = instance_options[:replies] || []
    replies[object.id]
  end
end
