class PokedexsController < ApplicationController
    def index
        @pokedexes = Pokedex.all
    end
    
    def show
        @pokedex = Pokedex.find(params[:id])
        @skills = @pokedex.skills
        @skills_info = Skill.where(element: @pokedex.element_1)
    end
    
end
