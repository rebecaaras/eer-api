class AddNotNullToSeries < ActiveRecord::Migration[8.1]
  def change
    change_column_null :series, :country_code, false
    change_column_null :series, :country_name, false
    change_column_null :series, :frequency, false
    change_column_null :series, :series_type, false
    change_column_null :series, :basket, false
  end
end
