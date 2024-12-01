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
	serialize :tchid,Hash
	serialize :admid,Hash
	serialize :bm,Array
	serialize :bi,Array
	serialize :mt,Array
	serialize :pi,Array
	belongs_to :kid
	belongs_to :taska
	has_many :fotos, :dependent => :delete_all
	accepts_nested_attributes_for :fotos
end
