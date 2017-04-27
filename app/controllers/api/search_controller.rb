class Api::SearchController < ApplicationController
  has_scope :by_identity_hash
  has_scope :by_tripcode
  has_scope :by_client_id

  def index
    apply_scopes(Post)
  end
end
