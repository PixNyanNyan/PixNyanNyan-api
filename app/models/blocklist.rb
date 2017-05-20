class Blocklist < ApplicationRecord
  scope :valid_rule, -> { where('blocked_until > ?', Time.now) }

  def self.ip?(ip)
    valid_rule.where('ip >>= ?', ip).size > 0
  end

  def self.client_id?(client_id)
    !client_id.nil? && valid_rule.where(client_id: client_id).size > 0
  end

  def self.similar_image?(image_hash)
    !image_hash.nil? && valid_rule.where('phash_hamming(image_hash, ?) <= 15', image_hash.to_s).size > 0
  end
end
