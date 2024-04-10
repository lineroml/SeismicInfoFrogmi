class AddLongitudeAndLatitudeToFeatures < ActiveRecord::Migration[7.1]
  def change
    add_column :features, :longitude, :decimal
    add_column :features, :latitude, :decimal
  end
end
