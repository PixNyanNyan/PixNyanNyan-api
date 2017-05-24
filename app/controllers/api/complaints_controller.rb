class Api::ComplaintsController < ApplicationController
  before_action :verify_recaptcha!, only: :create, unless: -> {ENV['BYPASS_RECAPTCHA']}
  before_action :authenticate_admin!, only: [:index, :show, :update, :destroy]
  before_action :find_complaint, only: [:show, :update, :destroy]

  def index
    complaints = range_query(Complaint.open_case.recent)

    render json: complaints
  end

  def create
    complaint = Complaint.new(complaint_params)
    complaint.ip = request.ip
    complaint.save!

    render json: complaint
  end

  def show
    render json: @complaint
  end

  def update
    render json: @complaint.update!(complaint_params)
  end

  def destroy
    render json: @complaint.destroy!
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
