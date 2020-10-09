class CreateLgbks < ActiveRecord::Migration[5.2]
  def change
    create_table :lgbks do |t|
      t.text :cin
      t.text :cout
      t.float :temp

      t.timestamps
    end
  end
end
