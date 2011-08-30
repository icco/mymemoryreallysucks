class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.string :account_id
      t.string :box_type
      t.string :token
    end
  end

  def self.down
    drop_table :boxes
  end
end
