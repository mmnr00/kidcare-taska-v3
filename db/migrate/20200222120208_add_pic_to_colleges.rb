class AddPicToColleges < ActiveRecord::Migration[5.2]
  def change
    add_column :colleges, :picurl, :string
  end
end
