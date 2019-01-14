class IdeasController < ApplicationController
    def index
        @ideas = Idea.all
    end

    def new
        @idea = Idea.new
    end

    private

    def idea_params
        params.require(:idea).permit(:title, :description)
    end
end
