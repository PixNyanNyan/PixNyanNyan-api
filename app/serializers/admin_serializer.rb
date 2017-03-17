class AdminSerializer < ActiveModel::Serializer
  attributes :id, :email, :display_name, :sign_in_count, :current_sign_in_at
  attributes :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
end
