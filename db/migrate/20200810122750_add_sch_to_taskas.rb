class AddSchToTaskas < ActiveRecord::Migration[5.2]
  def change
    add_column :taskas, :bldt, :integer
    add_column :taskas, :remdt, :integer
    add_column :taskas, :psldt, :integer
  end
end
