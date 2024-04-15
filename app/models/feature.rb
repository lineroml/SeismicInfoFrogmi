class Feature < ApplicationRecord

  has_many :comments, dependent: :destroy
  after_save :update_count

  def self.get_features_by_mag_type_paginated(mag_type_filter=nil, page=1, limit=20)
    offset = (page - 1) * limit
    if mag_type_filter
      features = Feature.where(mag_type: mag_type_filter)
      return features.limit(limit).offset(offset), features.count
    else
      return Feature.limit(limit).offset(offset), Feature.count
    end
  end

  def update_count
    update_column(:comment_count, comments.count)
  end

end
