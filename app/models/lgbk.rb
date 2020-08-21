class Lgbk < ApplicationRecord
	serialize :cin,Array
	serialize :cout,Array
	serialize :temp,Hash
	belongs_to :kid
end
