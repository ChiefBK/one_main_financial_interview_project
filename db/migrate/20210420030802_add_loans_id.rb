class AddLoansId < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :loan_id, :integer
  end
end
