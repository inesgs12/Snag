# frozen_string_literal: true
class WelcomeController < ApplicationController
  skip_before_action :require_login, only: :home

  def home
  end

  def leaderboards
    @users = User.all
    @requests = Request.all
    @beers = Beer.all
  end

  def closed
  end

end
