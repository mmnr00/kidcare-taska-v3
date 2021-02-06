class AddSokuToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :soku, :string
  end
end
