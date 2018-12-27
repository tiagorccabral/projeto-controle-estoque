class AddObservationsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :observation, :text
  end
end
