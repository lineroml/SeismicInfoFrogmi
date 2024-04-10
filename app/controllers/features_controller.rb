class FeaturesController < ApplicationController
  def index
    render json: Feature.all
  end
end
