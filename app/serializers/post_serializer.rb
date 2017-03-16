class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :email, :message, :identity_hash
  attributes :image_dimensions, :image_file_name, :image_file_size
  attributes :image_url_small, :image_url_medium, :image_url_orig
  attributes :locked, :is_admin, :created_at, :updated_at
  has_many :replies


  def image_url_small
    object.image.url(:small)
  end

  def image_url_medium
    object.image.url(:medium)
  end

  def image_url_orig
    object.image.url
  end
end
