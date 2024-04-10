class CreatePoems < ActiveRecord::Migration[7.1]
  def change
    create_table :poems do |t|
      t.string :title
      t.text :context

      t.timestamps
    end
  end
end
