class AddSpvToTaskaAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :taska_admins, :spv, :boolean
  end
end
