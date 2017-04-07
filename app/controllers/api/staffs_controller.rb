class Api::StaffsController < ApplicationController

  before_action :privilege_check

  def index
    render json: Admin.all
  end

  def create
    render json: Admin.create!(admin_params)
  end

  def update
    admin = Admin.find(params[:id])
    render json: admin.update!(admin_params)
  end

  private

  def privilege_check
    unless admin_signed_in? && current_admin.is_super_admin?
      raise AccessForbidden.new('Access denied')
    end
  end

  def admin_params
    params.require(
        :admin
      ).permit(
        :display_name,
        :super_admin,
        :email,
        :password,
        :enabled
    )
  end
end
