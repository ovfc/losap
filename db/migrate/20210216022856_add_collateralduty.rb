class AddCollateralduty < ActiveRecord::Migration
  def self.up
    create_table :collateraldutys do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :member_id

      t.timestamps
    end
    add_column :collateraldutys, :deleted, :boolean, :default => false, :null => false
    add_index :collateraldutys, :member_id
  end

  def self.down
    drop_table :collateraldutys
    remove_column :collateraldutys, :deleted
    remove_index :collateraldutys, :member_id
  end
end
