class Vltr < ApplicationRecord
	serialize :crs,Array
	belongs_to :taska, optional: true
	belongs_to :classroom, optional: true
	before_save :save_vltrs

	private

	def save_vltrs
		self.name = self.name.upcase
	end

end
