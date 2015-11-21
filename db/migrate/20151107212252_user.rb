class User < ActiveRecord::Migration
  def up
  	create_table :users do |t|
  		t.column "first_name", :string, :limit => 25
  		t.string "last_name", :limit => 50
  		t.string "password", :limit => 40
  		t.string "email", :null => false
  		t.timestamps
  	end
  end

  def down
  	drop_table :users
  end
end
