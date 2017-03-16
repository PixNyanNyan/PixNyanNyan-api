class Api::RecaptchaController < ApplicationController
  def index
    render json: {sitekey: ENV['RECAPTCHA_SITE_KEY'] }
  end
end
