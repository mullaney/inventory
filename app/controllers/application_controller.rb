class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :authenticate

  protected
    def authenticate
      if APP_CONFIG['perform_authentication']
        authenticate_or_request_with_http_basic do |username, password|
          puts "#{APP_CONFIG['username']}"
          username == APP_CONFIG['username'] && password == APP_CONFIG['password']
        end
      end
    end
end
