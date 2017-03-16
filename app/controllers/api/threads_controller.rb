class Api::ThreadsController < ApplicationController
  def index
    #Post.threads.after(params[:cursor]).includes(:replies).recent
    if admin_signed_in?
      render plain: 'YES'
    else
      render plain: 'NO'
    end
  end

  def show
    Post.find(params[:id]).after(params[:cursor]).includes(:replies)
  end
end
