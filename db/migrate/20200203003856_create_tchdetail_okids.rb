class CreateTchdetailOkids < ActiveRecord::Migration[5.2]
  def change
    create_table :tchdetail_okids do |t|
      t.integer :tchdetail_id
      t.integer :okid_id

      t.timestamps
    end
  end
end
