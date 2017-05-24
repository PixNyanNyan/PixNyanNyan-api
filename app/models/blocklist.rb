class Blocklist < ApplicationRecord
  scope :valid_rules, -> { where('blocked_until > ?', Time.now) }

  def self.rule_exist?(*params)
    valid_rules.where(*params).size > 0
  end

  def self.ip?(ip)
    !ip.nil? && rule_exist?('ip >>= ?', ip)
  end

  def self.client?(client_id)
    !client_id.nil? && rule_exist?(client_id: client_id)
  end

  def self.image?(image_hash)
    stmt = 'phash_hamming(image_hash, ?) <= ?'
    !image_hash.nil? && rule_exist?(stmt, image_hash.to_s, PHASH_THRESHOLD)
  end

  def self.create_from_post(id, options = {})
    post = Post.find(id)

    param = {
      image_hash: Phashion::Image.new(image_file).fingerprint,
      client_id: 123,
      ip: 321,
      blocked_until: 123
    }

    create!(param)
  end
end
