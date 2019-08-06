class Beer < ApplicationRecord
    has_many :requests
    has_many :kegs
    has_many :floors, through: :kegs

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :abv, presence: true
    validates :description, presence: true

    def self.most_popular
        requests = Request.all.where(:status => ["closed","open", "in progress"])
        requests.uniq.map{ |request| [request.beer, requests.where(beer:request.beer).count] }.to_h
    end

end
