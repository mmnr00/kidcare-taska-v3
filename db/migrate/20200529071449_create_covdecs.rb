class CreateCovdecs < ActiveRecord::Migration[5.2]
  def change
    create_table :covdecs do |t|
      t.string :mname
      t.string :mic
      t.string :mph
      t.string :moffc

      t.timestamps
    end
  end
end
