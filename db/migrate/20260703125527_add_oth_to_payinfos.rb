class AddOthToPayinfos < ActiveRecord::Migration[8.1]
  def change
    add_column :payinfos, :neisa, :float
    add_column :payinfos, :pcb, :float
  end
end
