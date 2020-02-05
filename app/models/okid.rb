class Okid < ApplicationRecord
	belongs_to	:college
	has_many :tchdetail_okids
	has_many :tchdetails, through: :tchdetail_okids
end
