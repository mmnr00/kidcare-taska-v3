class Lgbk < ApplicationRecord
	serialize :cin,Array
	serialize :cout,Array
	serialize :temp,Hash
	serialize :tool,Hash
	serialize :medc,Hash
	serialize :susu,Array
	serialize :mkn,Array
	serialize :ctm,Array
	serialize :aktl,Array
	serialize :aktp,Array
	serialize :lmpn,Array
	serialize :gigi,Array
	serialize :mnd,Array
	serialize :tdur,Array
	belongs_to :kid
	belongs_to :taska
end
