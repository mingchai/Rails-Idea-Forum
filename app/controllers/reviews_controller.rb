class ReviewsController < ApplicationController
    before_action :authorize_user!, only: [:destroy]
    
    def new
        @review = Review.new
    end

    def create
        @review = Review.new review_params
        @review.user = current_user
        @idea = Idea.find params[:idea_id]
        @review.idea = @idea
        if @review.save review_params
            redirect_to idea_path(@idea.id)
        else
            @reviews = @idea.reviews
            render "ideas/show"
        end
    end

    def destroy
        @review = Review.find params[:id]
        @review.destroy
        redirect_to idea_path(@review.idea)
    end

    private

    def review_params
        params.require(:review).permit(:title)
    end

    def authorize_user!
        unless can?(:crud, @review)
            flash[:danger] = "Access Denied: You do not have authorization to perform this action"
            redirect_to idea_path
        end
    end
end
