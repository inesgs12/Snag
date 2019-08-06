class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    if login(params[:username], params[:password])
      flash[:success] = 'Welcome back!'
      redirect_back_or_to requests_path
    else
      flash.now[:error] = 'Username and/or password is incorrect.'
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = 'See you!'
    redirect_to log_in_path
  end
end