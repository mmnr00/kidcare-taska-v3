class VltrsController < ApplicationController

	def new_vltr
		@vltr = Vltr.new
		@taska = Taska.find(params[:taska_id])
	end

	def crt_vltr
	end

	def edit_vltr
	end

	def upd_vltr
	end

	private

	def kid_params
      params.require(:vltr).permit(:name,
      														 :ic,
      														 :email,
      														 :ph,
      														 :address,
      														 :taska_id,
      														 :classroom_id)
  end

end 