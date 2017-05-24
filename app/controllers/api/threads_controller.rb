class Api::ThreadsController < ApplicationController
  def index
    posts = range_query(Post).recent.threads
    replies = Post.latest_replies(posts, MAX_PREVIEW_PER_THREAD)

    render json: posts, replies: replies, client_id: params[:client_id]
  end

  def show
    post = Post.threads.where(id: params[:id]).take!
    replies = {
      post.id => range_query(post.replies)
    }

    render json: post, replies: replies, client_id: params[:client_id]
  end
end
