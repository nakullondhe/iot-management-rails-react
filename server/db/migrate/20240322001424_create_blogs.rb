class CreateBlogs < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs do |t|
      t.string :name
      t.string :desc

      t.timestamps
    end
  end
end
