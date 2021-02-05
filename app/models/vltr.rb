class Vltr < ApplicationRecord
	serialize :crs,Array
	belongs_to :taska, optional: true
	belongs_to :classroom, optional: true
end
