class AddNeisToPayslips < ActiveRecord::Migration[8.1]
  def change
    add_column :payslips, :neisa, :float
  end
end
