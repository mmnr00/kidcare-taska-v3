class CreateAnsies < ActiveRecord::Migration[5.2]
  def change
    create_table :ansies do |t|
      t.string :name
      t.string :email
      t.string :ph
      t.string :owr
      t.string :rep
      t.string :phr
      t.string :att

      t.timestamps
    end
  end
end
