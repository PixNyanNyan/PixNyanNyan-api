class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :before, -> cursor { where('id < ?', cursor) if cursor.present? }
  scope :after, -> cursor { where('id > ?', cursor) if cursor.present? }
  scope :in_range, -> (lower, upper) { after(lower).before(upper) }

  after_validation :nullify_blank_attributes

  protected

  def nullify_blank_attributes
    attributes.each do |column, value|
      self[column] = nil if value == ''
    end
  end
end
