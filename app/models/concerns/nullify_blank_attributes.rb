module NullifyBlankAttributes
  extend ActiveSupport::Concern

  included do
    before_validation :nullify_blank_attributes
  end

  def nullify_blank_attributes
    attributes.each do |column, value|
      self[column] = nil if self[column] == ''
    end
  end
end
