class ApplicationController < ActionController::Base
  include CasAuthentication
  include SessionsHelper
  before_filter :login_required

  def logout
  end

  def handle_unverified_request
    sign_out
    super
  end
end
