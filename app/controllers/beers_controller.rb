class BeersController < ApplicationController
    before_action :find_beer, only: [:edit, :show, :update, :destroy]

    def index 
        @beers = Beer.all 
    end 

    def show 
    end 

    def new 
        @beer = Beer.new
    end 

    def create 
        @beer = Beer.new(beer_params)
        if @beer.valid?
            @beer.save
            flash[:notice] = "Beer was saved"
            redirect_to beers_path
        else 
            flash[:errors] = @beer.errors.full_messages
            flash[:notice] = "Brand was not saved"
            render :new 
        end
    end 

    def edit 
    end 

    def update 
        @beer.update(beer_params)
        if @beer.valid?
            redirect_to @beer
            flash[:notice] = "Beer has been udpated"
        else 
            flash[:errors] = @beer.errors.full_messages
            flash[:notice] = "Try again"
            redirect_to edit_beer_path
        end
    end 

    def destroy 
        @beer.destroy
        flash[:notice] = "Beer has been deleted"
        redirect_to brands_path
    end 

    private

    def beer_params 
        params.require(:beer).permit(:name, :abv, :description)
    end 

    def find_beer 
        @beer = Beer.find(params[:id])
    end 
    
end
