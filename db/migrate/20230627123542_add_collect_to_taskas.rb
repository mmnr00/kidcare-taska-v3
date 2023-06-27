class AddCollectToTaskas < ActiveRecord::Migration[6.1]
  def change
    add_column :taskas, :collection_name1, :string
    add_column :taskas, :collection_name2, :string
  end
end
