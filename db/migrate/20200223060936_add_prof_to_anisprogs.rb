class AddProfToAnisprogs < ActiveRecord::Migration[5.2]
  def change
    add_column :anisprogs, :profurl, :string
  end
end
