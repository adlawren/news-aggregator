class ApplicationController < ActionController::Base
  # before_action :authenticate_user! # TODO: Add support for non-basic auth
  before_action :http_authenticate

  def http_authenticate
    return if admin_username.blank? || admin_password.blank? # Disable Basic auth if admin username / password hasn't been set

    authenticate_or_request_with_http_basic do |user_name, password|
      ActiveSupport::SecurityUtils.secure_compare(user_name, admin_username) &&
        ActiveSupport::SecurityUtils.secure_compare(password, admin_password)
    end
  end

  private def admin_username
    ENV["ADMIN_USERNAME"]
  end

  private def admin_password
    ENV["ADMIN_PASSWORD"]
  end
end
