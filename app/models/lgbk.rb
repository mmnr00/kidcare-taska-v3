class Lgbk < ApplicationRecord
	serialize :cin, type: Array
	serialize :cout, type: Array
	serialize :temp, type: Hash
	serialize :tool, type: Hash
	serialize :medc, type: Hash
	serialize :susu, type: Array
	serialize :mkn, type: Array
	serialize :ctm, type: Array
	serialize :aktl, type: Array
	serialize :aktp, type: Array
	serialize :lmpn, type: Array
	serialize :gigi, type: Array
	serialize :mnd, type: Array
	serialize :tdur, type: Array
	serialize :tchid, type: Hash
	serialize :admid, type: Hash
	serialize :bm, type: Array
	serialize :bi, type: Array
	serialize :mt, type: Array
	serialize :pi, type: Array
	belongs_to :kid
	belongs_to :taska
	has_many :fotos, :dependent => :delete_all
	accepts_nested_attributes_for :fotos
end
