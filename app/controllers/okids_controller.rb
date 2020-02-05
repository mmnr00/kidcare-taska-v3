class OkidsController < ApplicationController
	before_action	:set_all

	def new_okid
		@tchdetail = Tchdetail.find(params[:tchdetail_id])
		@okids = @tchdetail.okids
	end

	def crt_okid
		params[:okid].each do |k,v|
			okd = Okid.create(name: v[:name], ic: v[:ic], college_id: 60)
			TchdetailOkid.create(tchdetail_id: v[:tcid], okid_id: okd.id)
		end
	end

	def edit_okid
		@tchdetail = Tchdetail.find(params[:tchdetail_id])
		@okids = @tchdetail.okids
	end

	def upd_okid
	end

	private

	def set_all
		@owner = current_owner
	end

end