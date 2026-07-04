class AddPcbToPayslips < ActiveRecord::Migration[8.1]
  def change
    add_column :payslips, :pcb, :float
  end
end
