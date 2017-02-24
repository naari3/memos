class AddMemoToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :memo_id, :integer
  end
end
