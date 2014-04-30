class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_if_required

  private

  # http://stackoverflow.com/questions/7972934/conditional-http-basic-authentication
  def authenticate_if_required
    if basic_auth_required?
      authenticate_or_request_with_http_basic 'Production' do |name, password|
        name == ENV["AUTH_PASS"] && password == ENV["AUTH_PASS"]
      end
    end
  end

  def basic_auth_required?
    Rails.env.production?
  end
end
