class AddStpToTskbills < ActiveRecord::Migration[5.2]
  def change
    add_column :tskbills, :stp, :float
  end
end
