class Api::PostsController < ApplicationController

  before_action :verify_recaptcha!, only: :create, unless: -> { admin_signed_in? }
  before_action :prevent_chubou, only: :create, unless: -> { admin_signed_in? }

  def create
    post = Post.new(post_params)
    post.ip = request.ip
    post.admin = current_admin if admin_signed_in?
    post.save!

    render json: post
  end

  def destroy
    id = [params[:id]].flatten
    id = id[0...10] if id.size > 10
    
    posts = Post.find(id)

    unless admin_signed_in?
      unless params[:passwd].is_a?(String)
        raise ActionController::BadRequest, 'params[:passwd] is not a string'
      end
      passwd = Post.gen_passwd(params[:passwd])
      posts = Post.where(id: posts, delete_password: passwd)
    end

    ActiveRecord::Base.transaction do
      if params[:del_pic]
        posts.each{ |post| post.image.destroy }
      else
        posts.each{ |post| post.destroy! }
      end
    end

    render json: posts
  end

  def search
    render json: apply_searchs, client_id: params[:client_id]
  end

  private

  def prevent_chubou

  end

  def apply_searchs
    scopes = [
      :by_identity_hash, :by_tripcode, :by_client_id,
      :by_title, :by_author, :by_email, :by_message
    ]
    scopes.reject!{|scope| params[scope].blank? }

    return [] if scopes.empty?

    scopes.map!{|scope| [scope, params[scope]] }

    Post.send_chain(scopes).in_range(params[:lower_limit], params[:upper_limit]).recent
  end

  def post_params
    params.require(
        :post
      ).permit(
        :parent_post_id,
        :title,
        :author,
        :email,
        :message,
        :image,
        :delete_password,
        :client_id
    )
  end
end
