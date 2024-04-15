module Api
  class FeaturesController < ApplicationController
    def index
      puts params
      page  = [params[:page].to_i, 1].max
      limit = params[:per_page] == nil ? 20 : [params[:per_page].to_i, 1000].min
      filter= params[:mag_type]

      features, count = Feature.get_features_by_mag_type_paginated(filter, page, limit)

      render json: {
        data: features.map do |feature|
          {
            id: feature.id,
            type: 'feature',
            attributes: {
              external_id: feature.external_id,
              magnitude: feature.magnitude,
              place: feature.place,
              time: feature.time,
              tsunami: feature.tsunami,
              mag_type: feature.mag_type,
              title: feature.title,
              coordinates: {
                longitude: feature.longitude,
                latitude: feature.latitude
              },
              comment_count: feature.comments.count
            },
            links: {
              external_url: feature.external_url
            }
          }
        end,
        pagination: {
          page: page,
          per_page: limit,
          total: count,
        }
      }
    end

    def show
      @feature = Feature.find(params[:id])
      comments_count = @feature.comments.count
      render json: @feature.as_json.merge({ comment_count: comments_count })
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Feature not found' }, status: :not_found
    end
  end
end
