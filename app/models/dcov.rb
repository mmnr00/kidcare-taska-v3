class Dcov < ApplicationRecord
	belongs_to :kid, optional: true
	belongs_to :taska, optional: true
	serialize :cond,Array
	serialize :upd_by,Array
end
