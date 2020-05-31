class ParentsController < ApplicationController
	require 'json'
	before_action :authenticate_parent!
	before_action :set_parent
	#before_action	:update_bills
	#$quarter = 3 || 6 || 9 || 12

	def dcov_prt
		@kid = Kid.find(params[:id])
	end

	def upd_covdesc
		@covdec = Covdec.where(kid_id: params[:covdec][:kid_id]).last
		@covdec.update(covdec_params)
		flash[:notice] = "Declaration Form Updated"
		redirect_to my_kid_path(id: @covdec.kid.parent_id)
	end

	def crt_covdesc
		@covdec = Covdec.new(covdec_params)
		@covdec.save
		flash[:notice] = "Declaration Form Submitted"
		redirect_to my_kid_path(id: @covdec.kid.parent_id)
	end

	def prt_cov
		@kid = Kid.find(params[:id])
		if @kid.covdec.present?
			@covdec = @kid.covdec
			@act = "upd_covdesc"
		else
			@covdec = Covdec.new
			@act = "crt_covdesc"
		end
		render action: "prt_cov", layout: "dsb-parent-child"
	end

	def parent
		@parent = current_parent
		redirect_to my_kid_path(@parent)
	end

	def my_kid
		@mykids = @parent.kids.order("name ASC")
		render action: "my_kid", layout: "dsb-parent-child"
	end

	def index
		@parent = current_parent
		#@mykids = @parent.kids.order('updated_at DESC')
		@unpaid_bills = @parent.payments.where(paid: false).order("bill_month DESC")
		#Prntdetail.create(parent_id: @parent.id)
		if 1==1
			redirect_to my_kid_path(@parent)
			##render action: "index", layout: "dsb-parent-child"
		else
			#redirect_to my_kid_path(@parent)
			redirect_to new_prntdetail_path(parent_id: @parent.id)
		end
	end

	

	def check_kid

		render action: "check_kid", layout: "dsb-parent-child"
	end

	def sch_kid
		@exs_kids = Kid.where(ic_1: params[:ic_1],ic_2:params[:ic_2],ic_3:params[:ic_3] )
		respond_to do |format|
      format.js { render partial: 'parents/rstkid' } 
    end
	end

	def prntschtsk
		# @taska = Taska.find(params[:taska_id])
		# if @taska.present? 
		# 	redirect_to new_kid_path(taska_id: @taska.id)
		# else
		  render action: "prntschtsk", layout: "dsb-parent-child"
		# end
		
	end

	def prntfndtsk
		if params[:tskname].blank?
			flash[:danger] = "NO INPUT ENTERED"
		else
			@taskas = Admin.first.taskas.where("name like?", "%#{params[:tskname].upcase}%").where.not(plan: "mbr19")
			flash[:danger] = "NO MATCHED DATA" unless @taskas.present?
		end
		respond_to do |format|
      format.js { render partial: 'parents/prntrsttsk' } 
    end
	end

	def mrg_kid
		@kid = Kid.find(params[:kid_id])
		@kid.parent_id = @parent.id
		if @kid.save
			flash[:success]="Children registration successful"
		else
			flash[:danger]="Registration failed. Please try again"
		end
		redirect_to my_kid_path(@parent)
	end

	def all_bills
		@kid = Kid.find(params[:kid_id])
		@kid_bills = @kid.payments.order("paid ASC").order("updated_at ASC")
		render action: "all_bills", layout: "dsb-parent-child"
	end

	def view_receipt
		@mykids = @parent.kids.order('created_at DESC')
		bills = @parent.payments.where(paid: true)
		@bills = bills.order('updated_at DESC')
	end

	def individual_bill
		@kid = Kid.find(params[:kid])
		@kid_bills = @kid.payments.where(bill_month: params[:month], bill_year: params[:year]) 
	end

	def parents_pay_bill

		@bill = Payment.find(params[:bill])
		#month = @bill.bill_month
		if (params[:dofeed] != "1")
			redirect_to "#{$billplz}bills/#{@bill.bill_id}" 
		else
			@kid = Kid.find(params[:kid])
			current_user = current_parent
			@feedback = Feedback.new
		end
		#feedback will be only on every quarter


	end

	def parents_feedback
		if (!params[:taska_rating].present? || !params[:classroom_rating].present?)
			flash[:danger] = "Please provide rating for both Taska & Classroom"
			redirect_to parents_pay_bill_path(id: @parent.id, 
                                        kid: params[:kid], 
                                        bill: params[:bill],
                                        bill_id: params[:bill_id],
                                        classroom_id: params[:classroom_id],
                                        dofeed: "1",
                                        taska_id: params[:taska_id])
		else 
			f_taska = Feedback.create(rating: params[:taska_rating],
																review: params[:taska_review], 
																taska_id: params[:taska_id])
			f_classroom = Feedback.create(rating: params[:classroom_rating],
																		review: params[:classroom_review],  
																		classroom_id: params[:classroom_id])
			flash[:success] = "Thanks for the feedback"
			redirect_to "#{$billplz}bills/#{params[:bill_id]}"
		end
	end


	private

	def covdec_params
		 params.require(:covdec).permit(:mname,
																		:mic,
																		:mph,
																		:moffc,
																		:fname,
																		:fic,
																		:fph,
																		:foffc,
																		:raddr,
																		:vaddr,
																		:mnph,
																		:hph,
																		:kid_id,
																		:taska_id)
	end

	def set_parent
		@parent = Parent.find(current_parent.id)
	end

	def update_bills
		parent = Parent.find(current_parent.id)
    kids = parent.kids
    unpaid = kids.payments.where(paid: false)
    unpaid.each do |bill|
    	url_bill = "#{ENV['BILLPLZ_API']}bills/#{bill.bill_id}"
	    data_billplz = HTTParty.post(url_collection.to_str,
	                  :body  => { }.to_json,
	                  :basic_auth => { :username => ENV['BILLPLZ_APIKEY'] },
	                  :headers => { 'Content-Type' => 'application/json', 
	                                'Accept' => 'application/json' })
	    data = JSON.parse(data_billplz.to_s)
	    if data["paid"]
	    	bill.paid = data["paid"]
	    	bill.save
	    end
  	end
    #render json: data_billplz
    redirect_to owner_index_path;

	end
end