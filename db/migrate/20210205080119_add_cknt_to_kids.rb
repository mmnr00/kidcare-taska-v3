class AddCkntToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :sib, :string
    add_column :kids, :mmeml, :string
    add_column :kids, :mmsct, :string
    add_column :kids, :mmgrd, :string
    add_column :kids, :fteml, :string
    add_column :kids, :ftsct, :string
    add_column :kids, :ftgrd, :string
  end
end
