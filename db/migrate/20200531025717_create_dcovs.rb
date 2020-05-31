class CreateDcovs < ActiveRecord::Migration[5.2]
  def change
    create_table :dcovs do |t|
      t.float :temp
      t.text :cond
      t.integer :kid_id
      t.integer :taska_id
      t.text :upd_by

      t.timestamps
    end
  end
end
