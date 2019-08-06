class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:error] = 'You have to authenticate to access this page.'
    redirect_to log_in_path
  end
end
