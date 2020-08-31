class Lgbk < ApplicationRecord
	serialize :cin,Array
	serialize :cout,Array
	serialize :temp,Hash
	serialize :tool,Hash
	serialize :medc,Hash
	belongs_to :kid
end
