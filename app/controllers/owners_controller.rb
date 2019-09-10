class OwnersController < ApplicationController

    before_action :authenticate_owner!
    before_action :correct_owner, except: [:change_password ]


    def new

    end

    def create

    end

    def update

    end

    def index
        @owner = Owner.find(params[:id])
    end

    def show
        @owner = Owner.find(params[:id])
    end

    def edit

    end

end
