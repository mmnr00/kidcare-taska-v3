class AddPrevscToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :prevsc, :string
  end
end
