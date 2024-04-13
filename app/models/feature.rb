class Feature < ApplicationRecord

  has_many :comments, dependent: :destroy
  after_save :update_count

  def self.get_features_by_mag_type_paginated(mag_type_filter=nil, page=1, limit=20)
    offset = (page - 1) * limit
    if mag_type_filter
      Feature.where(mag_type: mag_type_filter).limit(limit).offset(offset)
    else
      Feature.limit(limit).offset(offset)
    end
  end

  def update_count
    update_column(:comment_count, comments.count)
  end

end
