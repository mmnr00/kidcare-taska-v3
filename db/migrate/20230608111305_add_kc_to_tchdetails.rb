class AddKcToTchdetails < ActiveRecord::Migration[6.1]
  def change
    add_column :tchdetails, :kapstat, :string
    add_column :tchdetails, :foodstat, :string
    add_column :tchdetails, :typhdt, :date
    add_column :tchdetails, :typhexp, :date
    add_column :tchdetails, :cprstat, :string
    add_column :tchdetails, :cprdt, :date
    add_column :tchdetails, :startwork, :date
  end
end
