class AddTskToVltrs < ActiveRecord::Migration[5.2]
  def change
    add_column :vltrs, :taska_id, :integer
    add_column :vltrs, :classroom_id, :integer
  end
end
