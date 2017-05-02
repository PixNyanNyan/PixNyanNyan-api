class Complaint < ApplicationRecord
  include NullifyBlankAttributes

  belongs_to :post, optional: true

  validates :message, presence: true, length: { maximum: 500 }
  validates :name, length: { maximum: 200 }
  validates :email, length: { maximum: 200 }
  validates :ip, presence: true
  validates :post, presence: true, if: 'post_id.present?'

  scope :recent, -> { order(id: :desc) }
  scope :open_case, -> { where(status: 'open') }
end
