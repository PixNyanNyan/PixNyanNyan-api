class Api::ThreadsController < ApplicationController
  def index
    posts = Post.recent.threads.in_range(params[:lower_limit], params[:upper_limit]).limit(10)
    replies = Post.latest_replies(posts, 5)

    render json: posts, replies: replies, client_id: params[:client_id]
  end

  def show
    post = Post.threads.where(id: params[:id]).take!
    replies = {
      post.id => post.replies.in_range(params[:lower_limit], params[:upper_limit]).limit(10)
    }

    render json: post, replies: replies, client_id: params[:client_id]
  end
end
