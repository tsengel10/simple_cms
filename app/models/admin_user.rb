class AdminUser < BaseModel
	self.table_name = "admin_users"

	has_secure_password

	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, :through => :section_edits

	scope :sorted, ->() { order("last_name ASC, first_name ASC") }

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	
	validates_presence_of :first_name
	validates_length_of :first_name, :maximum => 255
	validates_presence_of :last_name
	validates_length_of :last_name, :maximum => 255

	validates_presence_of :username
	validates_length_of :username, :within => 4..25
	validates_uniqueness_of :username


	#validates_presence_of :email
	#validates_length_of :email, :maximum => 100
	#validates_uniqueness_of :email
	#validates_format_of :email, :with => EMAIL_REGEX
	#validates_confirmation_of :email
	validates :email, :presence =>true,
						:length => {:maximum => 100},
						:uniqueness => true,
						:format => {:with => EMAIL_REGEX},
						:confirmation => true

	validate :allowed_usernames
	FORBIDDEN_USERNAMES = ['unique', 'multi', 'gunloc', 'blahh']
	def allowed_usernames
		if FORBIDDEN_USERNAMES.include?(username)
			errors.add(:username, "has been restricted from use")
		end
	end

	def name
		return "#{self.first_name} #{self.last_name}"
	end

end
