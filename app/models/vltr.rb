class Vltr < ApplicationRecord
	belongs_to :taska, optional: true
	belongs_to :classroom, optional: true
end
