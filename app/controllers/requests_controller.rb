class RequestsController < ApplicationController
  before_action :set_request, only: %i[update show destroy feedback feedback_path]
  before_action :index_pack, only: %i[index update]
  before_action :include_beers, only: %i[index new create]
  before_action :include_locations, only: %i[new create]

  def index
    Request.timecheck
  end

  def new
    if !(Request.bar_open?) #check if the taps are open
      redirect_to closed_path #check if this user already has a request open
    else
      @request = Request.new
      @currently_snagging = current_user.currently_snagging
      @currently_requesting = current_user.currently_requesting
    end
  end

  def create
    @request = Request.new(request_params)
    if @request.valid?
      @request.save
      redirect_to requests_path
    else
      flash[:error] = @request.errors.full_messages.join
      render :new
    end
  end

  def update
    @request.update(request_params)
    if @request.valid?
      if @request.status == "bailed"    #save bailed snag for records, create a replacement snag to reopen it to snaggers
        replacement = @request.dup
        replacement.update(snagger_id:nil, status:"open")
        replacement.save
      end

      @request.save
      if @request.status == "in progress"  #if the request is still open after the change, go to its show page - else, go back to the index page
        redirect_to @request
      elsif @request.status == "closed"
        redirect_to requests_feedback_path(@request)
      else
        redirect_to requests_path
      end

    else
      flash[:error] = @request.errors.full_messages.join
      render :index
    end

  end

  def show
    @requester = @request.requester

    if @request.snagger_id.nil?
      @snagger = nil
    else
      @snagger = @request.snagger
    end

    @location = @request.location
    @beer = @request.beer
  end

  def feedback
  end

  def feedback_path
    beer = @request.beer
    floor = Floor.find_by(floor_number:feedback_params[:floor])
    keg = Keg.find_by(floor_id:floor.id,beer_id:beer.id)

    keg.update(status:feedback_params[:status])
    floor.update(cups:feedback_params[:cups])
    redirect_to requests_path
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def index_pack
    @open_requests = Request.open
    @currently_snagging = current_user.currently_snagging
    @currently_requesting = current_user.currently_requesting
    @kegs = Keg.all
    @floors = Floor.all
  end

  def include_beers
    @beers = Beer.all
  end

  def request_params
    params.require(:request).permit(:requester_id, :snagger_id, :beer_id, :location_id, :status)
  end

  def feedback_params
    params.permit(:status, :cups, :floor)
  end

  def include_locations
    @locations = Location.all
  end
end
