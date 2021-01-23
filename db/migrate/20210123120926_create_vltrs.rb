class CreateVltrs < ActiveRecord::Migration[5.2]
  def change
    create_table :vltrs do |t|
      t.string :name
      t.string :ic
      t.string :email
      t.string :ph
      t.string :address

      t.timestamps
    end
  end
end
