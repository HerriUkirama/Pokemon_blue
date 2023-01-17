class HistoriesController < ApplicationController
    def index
        @histories = Battle.all
    end

    def show
        @battle = Battle.find(params[:id])
        @histories = @battle.battle_details
    end
    
    
end
