class AddOthnToTaskas < ActiveRecord::Migration[5.2]
  def change
    add_column :taskas, :othnm, :string
  end
end
