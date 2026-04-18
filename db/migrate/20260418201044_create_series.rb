class CreateSeries < ActiveRecord::Migration[8.0]
  def change
    create_table :series do |t|
      t.string :country_code
      t.string :country_name
      t.string :frequency
      t.string :series_type
      t.string :basket

      t.timestamps
    end
  end
end
