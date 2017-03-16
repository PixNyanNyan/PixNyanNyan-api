class Api::PostsController < ApplicationController

  before_action :prevent_chubou, only: :create

  def create
    post = Post.new(post_params)
    post.ip = request.ip
    post.is_admin = true if admin_signed_in?

    post.save!
  end

  def destroy
    
  end

  private

  def prevent_chubou
    #raise('asd') unless verify_recaptcha
  end

  def post_params
    params.require(
        :post
      ).permit(
        :title,
        :author,
        :email,
        :message,
        :image,
        :delete_password
    )
  end
end
