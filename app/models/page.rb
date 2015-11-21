class Page < BaseModel
	self.table_name = "pages"
	self.primary_key = "id"

	before_validation :add_default_permalink
	after_save :touch_subject
	after_destroy :delete_related_sections

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_presence_of :permalink
	validates_length_of :permalink, :within => 3..255
	validates_uniqueness_of :permalink

	belongs_to :subject
	has_and_belongs_to_many :editors, :class_name => "AdminUser"

	has_many :sections, :class_name => "Section", :foreign_key => "page_id"
	
	scope :sorted, ->() { order("name asc") }
	scope :visible, ->() { where("visible = ?", true) }

	acts_as_list :scope => :subject

	private

		def add_default_permalink
			if permalink.blank?
				self.permalink = "#{id}-#{name.parameterize}"
			end
		end

		def parameterize
			
		end

		def touch_subject
			# touch is similar to:
			# subject.update_attribute(:updated_at, Time.now)
			subject.touch
		end

		def delete_related_sections
			self.sections.each do |section|
				section.destroy
			end
		end


end
