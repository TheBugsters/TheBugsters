class AddPasswordToUserRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :user_records, :password_digest, :string
  end
end
