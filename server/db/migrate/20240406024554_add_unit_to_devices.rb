class AddUnitToDevices < ActiveRecord::Migration[7.1]
  def change
    add_column :devices, :unit, :string
  end
end
