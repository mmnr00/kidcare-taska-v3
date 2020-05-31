class Dcov < ApplicationRecord
	belongs_to :kid
	belongs_to :taska
	serialize :cond,Array
	serialize :upd_by,Hash
end
