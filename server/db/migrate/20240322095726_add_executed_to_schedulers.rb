class AddExecutedToSchedulers < ActiveRecord::Migration[7.1]
  def change
    add_column :schedulers, :executed, :boolean
  end
end
