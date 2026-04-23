class AddUniqueConstraintToObservation < ActiveRecord::Migration[8.1]
  def change
    add_index :observations, [ :series_id, :observed_on ], unique: true
  end
end
