class AddWkndToTaskas < ActiveRecord::Migration[6.1]
  def change
    add_column :taskas, :weekend, :string
  end
end
