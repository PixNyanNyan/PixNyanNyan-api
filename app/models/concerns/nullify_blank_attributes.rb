module NullifyBlankAttributes
  extend ActiveSupport::Concern

  included do
    after_validation :nullify_blank_attributes
  end

  def nullify_blank_attributes
    attributes.each do |column, value|
      self[column] = nil if value == ''
    end
  end
end
