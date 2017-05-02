class Api::ComplaintsController < ApplicationController
  before_action :verify_recaptcha!, only: :create
  before_action :authenticate_admin!, only: [:index, :show, :update, :destroy]
  before_action :find_complaint, only: [:show, :update, :destroy]

  def index
    Complaint.all
  end

  def create
    complaint = Complaint.new(complaint_params)
    complaint.ip = request.ip
    complaint.save!

    render json: complaint
  end

  def show
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def find_complaint
    @complaint = Complaint.find(params[:id])
  end

  def complaint_params
    params.require(
        :complaint
      ).permit(
        :post_id,
        :name,
        :email,
        :message
    )
  end
end
