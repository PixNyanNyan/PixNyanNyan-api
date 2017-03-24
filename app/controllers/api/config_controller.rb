class Api::ConfigController < ApplicationController
  def index
    render json: {
      recaptcha_site_key: ENV['RECAPTCHA_SITE_KEY'],
      image_max_size: MAX_IMAGE_KB_SIZE.kilobytes,
      message_max_wordcount: MAX_POST_MESSAGE_WORDCOUNT
    }
  end
end
