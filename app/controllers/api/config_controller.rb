class Api::ConfigController < ApplicationController
  def index
    render json: {
      recaptcha_site_key: ENV['RECAPTCHA_SITE_KEY'],
      image_max_size: MAX_IMAGE_SIZE,
      message_max_wordcount: MAX_POST_MESSAGE_WORDCOUNT,
      record_per_query: MAX_RECORD_PER_QUERY,
      preview_per_thread: MAX_PREVIEW_PER_THREAD
    }
  end
end
