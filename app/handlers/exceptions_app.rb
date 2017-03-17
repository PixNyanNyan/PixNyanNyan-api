class ExceptionsApp < Rambulance::ExceptionsApp
  def self.call(env)
    action('json_error').call(env)
  end

  def json_error
    render json: {error: exception.message}
  end
end
