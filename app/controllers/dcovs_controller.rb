class DcovsController < ApplicationController

	def crt_dcov
		pars = params[:dcov]
		@dcov = Dcov.new(temp: pars[:temp],
									kid_id: pars[:kid],
									taska_id: pars[:taska])
		@dcov.cond << pars[:fvr]
		@dcov.cond << pars[:cgh]
		@dcov.cond << pars[:flu]
		@dcov.cond << pars[:sore]
		@dcov.cond << pars[:brd]
		@dcov.cond << pars[:otsy]
		if current_parent.present?
			@dcov.upd_by << "p"
			@dcov.upd_by << current_parent.id
			redirect_to my_kid_path(id: @dcov.kid.parent_id)
		elsif current_admin.present?
		elsif current_teacher.present?
			@dcov.upd_by << "t"
			@dcov.upd_by << current_teacher.id
			redirect_to lstch_dcov_path(tsk: @dcov.kid.taska_id)
		end
		@dcov.save
		flash[:success] = "Health Status Updated"
		if (@dcov.temp > 100) || (@dcov.cond.include? "Yes") || (@dcov.cond[5].present?)
			puts "Send Email"
		end
		
	end



	private

	def dcov_params
	end

end