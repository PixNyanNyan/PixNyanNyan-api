class ComplaintSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :ip, :message, :status
  attributes :post_id, :created_at, :updated_at
end
