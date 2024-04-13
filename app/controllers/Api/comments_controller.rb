module Api
  class CommentsController < ApplicationController

    def index
      @comments = Feature.find(params[:feature_id].to_i).comments
      render json: @comments
    end

    def create
      feature = Feature.find(params[:feature_id].to_i)
      comment = feature.comments.create(comment_params)
      render json: comment, status: :created
    end

    private

    def comment_params
      params.require(:comment).permit(:text)
    end

  end
end
