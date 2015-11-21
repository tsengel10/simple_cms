class Subject < BaseModel
	self.table_name = "subjects"
	self.primary_key = "id"

	has_many :pages, :class_name => "Page", :foreign_key => "subject_id"

	validates_presence_of :name
	validates_length_of :name, :minimum => 3,:maximum => 255

	scope :visible, ->() { where(:visible => true) }
	scope :invisible, ->() { where(:visible => false) }
	scope :sorted, ->() { order("subjects.position ASC") }
	scope :newest_first, ->() { where("subjects.created_at DESC") }
	scope :search, ->(query) { where(["name LIKE ?", "%#{query}%"]) }

	acts_as_list # Method call. Adds intelligence of how to position them
	after_destroy :delete_related_pages

	private

		def delete_related_pages
			self.pages.each do |page|
				page.destroy
			end
		end
end
