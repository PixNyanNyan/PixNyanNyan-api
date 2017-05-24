class ApplicationController < ActionController::API
  include Recaptcha::Verify

  protected

  def range_query(model)
    model.in_range(params[:lower_limit], params[:upper_limit]).limit(MAX_RECORD_PER_QUERY)
  end
end
