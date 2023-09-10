class AddTncToTeachers < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :tnc, :string
  end
end
