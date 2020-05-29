class AddItToCovdecs < ActiveRecord::Migration[5.2]
  def change
    add_column :covdecs, :fname, :string
    add_column :covdecs, :fic, :string
    add_column :covdecs, :fph, :string
    add_column :covdecs, :foffc, :string
    add_column :covdecs, :raddr, :string
    add_column :covdecs, :vaddr, :string
    add_column :covdecs, :mnph, :string
    add_column :covdecs, :hph, :string
    add_column :covdecs, :kid_id, :integer
    add_column :covdecs, :taska_id, :integer
  end
end
