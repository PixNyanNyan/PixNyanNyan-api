class Api::ThreadsController < ApplicationController
  def index
    posts = Post.recent.threads.in_range(params[:lower_limit], params[:upper_limit]).limit(10)
    replies = Post.latest_replies(posts, 5)

    render json: posts, replies: replies
  end

  def show
    post = Post.find(params[:id])
    replies = {
      post.id => post.replies.in_range(params[:lower_limit], params[:upper_limit]).limit(10)
    }

    render json: post, replies: replies
  end
end
