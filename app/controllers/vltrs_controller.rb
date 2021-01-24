class VltrsController < ApplicationController

	before_action :set_all

	def new_vltr
		@vltr = Vltr.new
		@taska = Taska.find(params[:taska_id])
	end

	def crt_vltr
		@vltr = Vltr.new(vltr_params)
		@taska = @vltr.taska

		if Vltr.where(ic: @vltr.ic).present?
			flash[:danger] = "Data already exist. Please contact admin"
			redirect_to cakna21_path(volunteer: 1) and return
		end

		if @vltr.save
			flash[:success] = "#{@vltr.name} successfully registered to #{@taska.name}"
		else
			flash[:danger] = "Volunteer registration failed with error #{@kid.errors.full_messages}"
		end

		redirect_to cakna21_path(volunteer: 1)
	end

	def edit_vltr
		@vltr = Vltr.find(params[:id])
		@taska = @vltr.taska
	end

	def upd_vltr
		@vltr = Vltr.find(params[:vltr][:id])
		@vltr.update(vltr_params)
	end

	private

	def set_all
		@admin = current_admin
	end

	def vltr_params
      params.require(:vltr).permit(:name,
      														 :ic,
      														 :email,
      														 :ph,
      														 :address,
      														 :taska_id,
      														 :classroom_id)
  end

end 