class CreateOkids < ActiveRecord::Migration[5.2]
  def change
    create_table :okids do |t|
      t.string :name
      t.string :ic
      t.integer :college_id
      t.boolean :stat

      t.timestamps
    end
  end
end
