class AddUnitToAlarms < ActiveRecord::Migration[7.1]
  def change
    add_column :alarms, :unit, :string
  end
end
