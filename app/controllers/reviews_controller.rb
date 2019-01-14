class ReviewsController < ApplicationController
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
        
    end

    private

    def review_params
        params.require(:review).permit(:title)
    end
end
