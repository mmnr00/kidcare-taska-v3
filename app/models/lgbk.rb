class Lgbk < ApplicationRecord
	serialize :cin,Array
	serialize :cout,Array
	belongs_to :kid
end
