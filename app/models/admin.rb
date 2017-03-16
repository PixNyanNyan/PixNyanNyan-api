class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable
  # :rememberable, :validatable
  devise :database_authenticatable, :recoverable, :trackable
end
