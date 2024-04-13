class AddCommentCountToFeature < ActiveRecord::Migration[7.1]
  def change
    add_column :features, :comment_count, :integer
  end
end
