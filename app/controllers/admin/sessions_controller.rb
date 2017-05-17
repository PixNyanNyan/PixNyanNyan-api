class Admin::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new  
  end

  # POST /resource/sign_in
  def create
    verify_recaptcha! unless admin_signed_in? || ENV['BYPASS_RECAPTCHA']

    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    resource.update_login_info!(request.ip) if params[:admin]

    render json: {accessToken: JWTWrapper.encode({"#{resource_name}_id" => resource.id})}
  end

  # DELETE /resource/sign_out
  def destroy
  end
end
