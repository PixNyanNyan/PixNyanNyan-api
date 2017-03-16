class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable
  # :rememberable, :trackable, :validatable, :database_authenticatable
  devise :recoverable
end
