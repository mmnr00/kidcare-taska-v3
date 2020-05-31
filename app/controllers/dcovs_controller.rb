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
		end
		@dcov.save
		flash[:success] = "Health Status Updated"
		
	end



	private

	def dcov_params
	end

end