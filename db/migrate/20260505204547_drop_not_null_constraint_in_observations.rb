class DropNotNullConstraintInObservations < ActiveRecord::Migration[8.1]
  def change
    change_column_null :observations, :value, true
  end
end
