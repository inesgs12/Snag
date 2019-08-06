class LocationsController < ApplicationController
    
    def index 
        @locations = Location.all 
    end 

    def show
    end 

    def new
        @location = Location.new 
    end 

    def create 
    end 

end
