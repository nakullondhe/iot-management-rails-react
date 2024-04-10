class AddDeviceIdToDevices < ActiveRecord::Migration[7.1]
  def change
    add_column :devices, :device_id, :string
  end
end
