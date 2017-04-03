class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable
  # :rememberable, :validatable, :trackable
  devise :database_authenticatable, :recoverable

  has_many :posts

  def is_super_admin?
    self[:super_admin]
  end

  def update_login_info!(ip)
    self[:sign_in_count] += 1
    self[:last_sign_in_at] = self[:current_sign_in_at]
    self[:current_sign_in_at] = Time.zone.now
    self[:last_sign_in_ip] = self[:current_sign_in_ip]
    self[:current_sign_in_ip] = ip
    save!
  end

  def active_for_authentication?
    super && self[:enabled]
  end
end
