class Lgbk < ApplicationRecord
	serialize :cin,Array
	serialize :cout,Array
	serialize :temp,Hash
	serialize :tool,Hash
	serialize :medc,Hash
	serialize :susu,Array
	belongs_to :kid
	belongs_to :taska
end
