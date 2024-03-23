class CreateDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :model
      t.string :serial_number
      t.string :string
      t.string :system_id

      t.timestamps
    end
  end
end
