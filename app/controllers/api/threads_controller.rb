class Api::ThreadsController < ApplicationController
  def index
    posts = Post.threads.after(params[:cursor]).includes(:replies).recent

    render json: posts, include: 'replies'
  end

  def show
    post = Post.find(params[:id])

    render json: post, include: 'replies'
  end
end
