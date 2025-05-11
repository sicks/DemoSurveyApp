module AuthenticationHelper
  def authenticate(session)
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    my_cookies.signed[:session_id] = session.id
    cookies[:session_id] = my_cookies[:session_id]
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper
end
