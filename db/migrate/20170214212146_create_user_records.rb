class CreateUserRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :user_records do |t|
      t.string :name

      t.timestamps
    end
  end
end
