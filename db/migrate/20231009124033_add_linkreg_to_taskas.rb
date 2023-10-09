class AddLinkregToTaskas < ActiveRecord::Migration[6.1]
  def change
    add_column :taskas, :linkreg, :string
  end
end
