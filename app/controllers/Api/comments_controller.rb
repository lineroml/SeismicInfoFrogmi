module Api
  class CommentsController < ApplicationController

    def index
      @comments = Feature.find(params[:feature_id].to_i).comments
      render json: @comments
    end

    def create
      # Find the feature. The feature_id is passed in the URL.
      feature = Feature.find(params[:feature_id].to_i)
      comment_text = params[:body]
      if comment_text.nil? || comment_text.empty?
        render json: {error: "Comment text is required"}, status: :bad_request
        return
      end
      comment = feature.comments.create(text: comment_text)
      render json: comment, status: :created
    end

  end
end
