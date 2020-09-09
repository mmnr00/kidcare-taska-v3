class LgbksController < ApplicationController

	before_action :set_all

	def tch_upd
		@lgbk = Lgbk.find(params[:lgbk])

		#start for susu
		susu_n = params[:susu_n].to_i
		@lgbk.susu = nil
		(0..susu_n).each do |n|
			if params[:"st#{n}"].present? && params[:"sk#{n}"].present?
				@lgbk.susu[n] = [params[:"st#{n}"],params[:"sk#{n}"]]
			elsif @lgbk.susu[n].present?
				@lgbk.susu.delete_at(n)
			end
		end 
		ind = 0
		@lgbk.susu.each do |n|
			@lgbk.susu.delete_at(ind) unless n.present?
			ind += 1
		end
		@lgbk.susudc = params[:susudc]
		#end for susu

		#makan
		@lgbk.mkn = [params[:mknpg],params[:mkntg],params[:mknpt],params[:mkndc]]
		#circle time
		@lgbk.ctm = [params[:ctmm],params[:ctmdc]]
		#aktiviti luar
		@lgbk.aktl = [params[:aktlm],params[:aktldc]]
		#aktiviti permata
		@lgbk.aktp = [params[:aktpm],params[:aktpdc]]
		#lampin/tandas
		@lgbk.lmpn = [params[:lmpm],params[:lmpt],params[:lmpp],params[:lmpn],params[:lmpw],params[:lmpdc]]
		#gigi
		@lgbk.gigi = [params[:ggm],params[:ggt],params[:ggp],params[:ggdc]]
		#mandi
		@lgbk.mnd = [params[:mndm],params[:mndt],params[:mndp],params[:mnddc]]
		#tidur
		@lgbk.tdur = [params[:tdrm],params[:tdrt],params[:tdrp],params[:tdrdc]]
		#aktiviti bebas
		@lgbk.aktb = params[:aktb]
		#tingkah laku
		@lgbk.othdc = params[:othdc]

		@lgbk.save
		flash[:notice] = "Logbook updated successfully"
		redirect_to request.referrer
	end

	def tch_lgbk
		@lgbk = Lgbk.find(params[:lgbk])
		@kid = @lgbk.kid
		@tm = Time.now
		@taska = @lgbk.taska
		if @admin
		elsif @teacher
			render action: "tch_lgbk", layout: "dsb-teacher-tsk-nosb"
		end
	end

	def view_lgbk
		@lgbk = Lgbk.find(params[:lgbk])

		if params[:pdf].present?
			respond_to do |format|
		 		format.html
		 		format.pdf do
			   render pdf: "#{@lgbk.kid.name}",
			   template: "lgbks/view_lgbk.html.erb",
			   #disposition: "attachment",
			   #save_to_file: Rails.root.join('pdfs', "#{filename}.pdf"),
	       #save_only: true, 
			   #page_size: "A6",
			   orientation: "portrait",
			   layout: 'pdf.html.erb'
				end
			end
		else
			if params[:tch].present?
				render action: "view_lgbk", layout: "dsb-teacher-tsk-nosb"
			else
				render action: "view_lgbk", layout: "dsb-parent-child-nosb"
			end
		end
		
	end

	def prt_lgbk
		@kid = Kid.find(params[:kid_id])
		@tm = Time.now
		if params[:lgbk].present?
			@lgbk = Lgbk.find(params[:lgbk])
			@tm = @lgbk.created_at
		elsif (lgbk = @kid.lgbks.where(created_at: @tm.beginning_of_day..@tm.end_of_day)).present?
			@lgbk = lgbk.last
		else
			@lgbk = Lgbk.new
		end
		render action: "prt_lgbk", layout: "dsb-parent-child-nosb"
	end

	def prt_upd
		@kid = Kid.find(params[:kid_id])
		@tm = Time.now
		if params[:lgbk].present?
			@lgbk = Lgbk.find(params[:lgbk])
			@tm = @lgbk.created_at
		elsif (lgbk = @kid.lgbks.where(created_at: @tm.beginning_of_day..@tm.end_of_day)).present?
			@lgbk = lgbk.last
		else
			@lgbk = Lgbk.new
			@lgbk.kid_id = @kid.id
			@lgbk.taska_id = @kid.taska_id
			@lgbk.save
		end		
		@lgbk.update(tdo: params[:tdo],
								sih: params[:sih],
								sbb: params[:sbb],
								mand: params[:mand],
								phyc: params[:phyc])
		@lgbk.tool = {"tool1" => params[:tool1],"tool2" => params[:tool2],"tool3" => params[:tool3],
									"tool4" => params[:tool4],"tool5" => params[:tool5],"tool6" => params[:tool6],
									"tool7_d" => params[:tool7_d],"tool8_d" => params[:tool8_d],"tool9_d" => params[:tool9_d],
									"tool7" => params[:tool7],"tool8" => params[:tool8],"tool9" => params[:tool9]}
		@lgbk.medc = {"med1_d" => params[:med1_d],"med1_p" => params[:med1_p],"med1_n" => params[:med1_n],
									"med2_d" => params[:med2_d],"med2_p" => params[:med2_p],"med2_n" => params[:med2_n],
									"med3_d" => params[:med3_d],"med3_p" => params[:med3_p],"med3_n" => params[:med3_n]}
		@lgbk.save
		flash[:success] = "Logbook successfully updated"
		redirect_to request.referrer
	end

	def std_checkin
		kid = Kid.find(params[:kid])
		tch = Teacher.find(params[:tch])
		lgbk = kid.lgbks.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
		if lgbk.blank?
			lg_curr = Lgbk.new(kid_id: kid.id, taska_id: kid.taska.id)
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

	def lgbk_params
		params.permit(:bank_name,
                  :acc_no,
                  :acc_name,
                  :ssm_no)
	end

end