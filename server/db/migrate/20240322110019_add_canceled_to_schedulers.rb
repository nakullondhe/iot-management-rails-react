class AddCanceledToSchedulers < ActiveRecord::Migration[7.1]
  def change
    add_column :schedulers, :canceled, :boolean
  end
end
