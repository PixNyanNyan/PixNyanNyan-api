class Api::BlocklistsController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_blocklist, only: [:update, :destroy]

  def index
    render json: range_query(Blocklist)
  end

  def create
    render json: Blocklist.create!(blocklist_params)
  end

  def update
    render json: @blocklist.update!(blocklist_params)
  end

  def destroy
    render json: @blocklist.destroy!
  end

  private

  def find_blocklist
    @blocklist = Blocklist.find(params[:id])
  end

  def blocklist_params
    params.require(
        :blocklist
      ).permit(
        :client_id,
        :ip,
        :image_hash,
        :blocked_until
    )
  end
end
