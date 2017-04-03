class AccessForbidden < StandardError
  attr_accessor :message
  def initialize(msg)
    @message = msg
  end
end
