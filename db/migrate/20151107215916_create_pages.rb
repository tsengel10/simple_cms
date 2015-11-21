class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.column "subject_id", :int
    	t.column "name", :string, :limit =>255
    	t.column "position", :int
    	t.column "permalink", :string
    	t.column "visible", :boolean, :default => false
      t.timestamps
    end
    
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
  end

  def down
  		drop_table :pages
  end
end
