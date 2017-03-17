class ApplicationController < ActionController::API
  include Recaptcha::Verify
end
