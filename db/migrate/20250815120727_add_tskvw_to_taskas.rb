class AddTskvwToTaskas < ActiveRecord::Migration[8.0]
  def change
    add_column :taskas, :tskvw, :string
  end
end
