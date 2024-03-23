class AddActiveToDevices < ActiveRecord::Migration[7.1]
  def change
    add_column :devices, :active, :boolean
  end
end
