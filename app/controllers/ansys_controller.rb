class AnsysController < ApplicationController

	before_action :set_all

	def rsvp_list
	end

	private

	def set_all
		@owner = current_owner
		@admin = current_admin
		@teacher = current_teacher
		@parent = current_parent
	end


end