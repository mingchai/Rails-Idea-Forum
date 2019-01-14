class IdeasController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:edit, :update]
    
    def index
        @ideas = Idea.all
    end

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new idea_params
        @idea.user = current_user

        if @idea.save
            redirect_to ideas_path
        else
            render :new
        end
    end

    def show
        @idea = Idea.find params[:id]
        @reviews = @idea.reviews
        @review = Review.new
    end

    def edit
        @idea = Idea.find params[:id]
    end

    def update
        @idea = Idea.find params[:id]
        
        if @idea.update idea_params
            redirect_to idea_path(@idea.id)
        else
            render :edit
        end
    end

    def destroy
        @idea = Idea.find params[:id]
        if can?(:crud, @idea)
            @idea.destroy
            redirect_to ideas_path
        else
            flash[:danger] = "Access Denied: You do not have authorization to perform this action"
            redirect_to idea_path
        end
        
    end

    private

    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def authorize_user!
        unless can?(:crud, @idea)
            flash[:danger] = "Access Denied: You do not have authorization to perform this action"
            redirect_to idea_path
        end
    end
end
