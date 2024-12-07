class AddWabaToTaskas < ActiveRecord::Migration[6.1]
  def change
    add_column :taskas, :waba, :text
  end
end
