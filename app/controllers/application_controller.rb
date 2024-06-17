class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_current_user

  private

  def set_current_user
    @user_name = current_user if logged_in?
  end
end
