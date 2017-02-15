class AddUsernameToUserRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :user_records, :username, :string
  end
end
