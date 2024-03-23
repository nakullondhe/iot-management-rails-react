class CreateSchedulers < ActiveRecord::Migration[7.1]
  def change
    create_table :schedulers do |t|
      t.string :name
      t.string :action
      t.string :device_id
      t.string :date_time

      t.timestamps
    end
  end
end
