class AnsysController < ApplicationController

	before_action :set_all

	def rsvp_list
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def set_all
		@owner = current_owner
		@admin = current_admin
		@teacher = current_teacher
		@parent = current_parent
	end


end