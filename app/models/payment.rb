class Payment < ApplicationRecord
	belongs_to :parent, optional: true
	belongs_to :taska, optional: true
	belongs_to :teacher, optional: true
	belongs_to :course, optional: true
	has_many :kid_bills, dependent: :destroy
	has_many :kids, through: :kid_bills
	has_many :addtns, dependent: :destroy
	has_one :tskbill
	has_many :fotos, dependent: :destroy
	has_many :parpayms, dependent: :destroy
	has_many :otkids, dependent: :destroy
	accepts_nested_attributes_for :addtns
	accepts_nested_attributes_for :fotos
	include HTTParty

	


end
