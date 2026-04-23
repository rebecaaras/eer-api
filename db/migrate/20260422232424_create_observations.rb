class CreateObservations < ActiveRecord::Migration[8.1]
  def change
    create_table :observations do |t|
      t.references :series, null: false, foreign_key: true, type: :integer
      t.date :observed_on, null: false
      t.decimal :value, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
