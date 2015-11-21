class Section < BaseModel
	self.table_name = "sections"
	self.primary_key = "id"

	after_save :touch_page

	validates_presence_of :name
	validates_length_of :name, :maximum => 255

	CONTENT_TYPES = ['TEXT', 'HTML']
	validates_inclusion_of :content_type, :in => CONTENT_TYPES,
		:messages => "must be one of: #{CONTENT_TYPES.join(', ')}"
	validates_presence_of :content

	belongs_to :page
	has_many :section_edits
	has_many :editors, :class_name => "AdminUser", :through => :section_edits

	scope :sorted, ->() { order("name DESC") }
	scope :visible, ->() { where("visible = ?", true) }
	acts_as_list :scope => :page
	
	private
		def touch_page
			page.touch
		end

end
