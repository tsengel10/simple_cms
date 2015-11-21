class CreateSections < ActiveRecord::Migration
    def change
    create_table :sections do |t|
    	t.column "page_id", :int
    	t.column "name", :string, :limit =>255
    	t.column "position", :int
    	t.column "visible", :boolean, :default => false
    	t.column "content_type", :string, :limit => 255
    	t.column "content", :text
    	t.timestamps
    end

    add_index("sections", "page_id")
  end

end
