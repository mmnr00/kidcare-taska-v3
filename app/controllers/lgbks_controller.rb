class LgbksController < ApplicationController

	before_action :set_all

	def prt_lgbk
		@kid = Kid.find(params[:kid_id])
		render action: "prt_lgbk", layout: "dsb-parent-child-nosb"
	end

	def std_checkin
		kid = Kid.find(params[:kid])
		tch = Teacher.find(params[:tch])
		lgbk = kid.lgbks.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
		if lgbk.blank?
			lg_curr = Lgbk.new(kid_id: kid.id)
		else
			lg_curr = lgbk.last
		end
		lg_curr.cin << Time.now
		lg_curr.cin << tch.id
		lg_curr.cin << params[:tmpi]
		lg_curr.save
		#flash[:notice] = "Check-in successful for #{kid.name} by #{tch.username}"
		redirect_to request.referrer
	end

	def std_checkout
		lg_curr = Lgbk.find(params[:lgbk])
		kid = lg_curr.kid
		tch = Teacher.find(params[:tch])
		lg_curr.cout << Time.now
		lg_curr.cout << tch.id
		lg_curr.cout << params[:tmpo]
		lg_curr.save
		#flash[:notice] = "Check-Out successful for #{kid.name} by #{tch.username}"
		redirect_to request.referrer
	end

	private

	def set_all
		@parent = current_parent
		@teacher = current_teacher
		@admin = current_admin
	end

end