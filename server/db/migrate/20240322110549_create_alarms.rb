class CreateAlarms < ActiveRecord::Migration[7.1]
  def change
    create_table :alarms do |t|
      t.string :device_id
      t.string :severity
      t.boolean :acknowledged

      t.timestamps
    end
  end
end
