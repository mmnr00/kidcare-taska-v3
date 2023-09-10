class AddTncToParents < ActiveRecord::Migration[6.1]
  def change
    add_column :parents, :tnc, :string
  end
end
