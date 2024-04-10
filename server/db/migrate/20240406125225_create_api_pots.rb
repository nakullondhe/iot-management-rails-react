class CreateApiPots < ActiveRecord::Migration[7.1]
  def change
    create_table :api_pots do |t|
      t.string :title
      t.text :context

      t.timestamps
    end
  end
end
