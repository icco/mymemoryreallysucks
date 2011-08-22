class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.string :account_id
      t.string :auth_token
    end
  end

  def self.down
    drop_table :boxes
  end
end
