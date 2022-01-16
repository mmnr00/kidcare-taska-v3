class PagesController < ApplicationController
	 require 'json'
	 
	 before_action :set_all
	 before_action :superadmin, only: [:bank_status]
	 #before_action :checkadmckn, only: [:rptckn,:prfvltr]

	#layout "dsb-admin-eg"

	def billplz21
		@kbl = Payment.where.not(bill_id2: nil).where(name: "KID BILL",paid: false)
		@kbl.each do |bl|
			check2_bill(bl.id)
			sleep 1.0
		end
		@kbl2 = Payment.where.not(bill_id2: nil).where(name: "KID BILL",paid: false)
		@kbl2.each do |bl2|
			bl2.bill_id2 = nil 
			bl2.save
		end
	end

	def cknxls
		@taskas = Taska.where(id: $cakna21)
		#kids List
		k = Kid.where(taska_id: $cakna21)
		k1 = k.where(taska_id: [286,606,592]).where.not(classroom_id: nil) 
		k2 = k.where.not(taska_id: [286,606,592])
		@kids = k1.or(k2)

		respond_to do |format|
    	#format.html
    	format.xlsx{
  								response.headers['Content-Disposition'] = 'attachment; filename="Senarai Program Cakna Anak.xlsx"'
			}
  	end
	end

	def prfvltr
		@vltr = Vltr.find(params[:id])
	end

	def cknvltr
		if params[:id].present?
			@taska = Taska.find(params[:id])
			@taskas = Taska.where(id: params[:id])
			@vltrs = @taska.vltrs
			if params[:sch].present?
				@vltrs = @vltrs.where(taska_id: params[:taska_id]) unless params[:taska_id].blank?
				@vltrs = @vltrs.where('name LIKE ?', "%#{params[:sch_str].upcase}%") unless params[:sch_str].blank?
			end
			render action: "cknvltr", layout: "dsb-admin-overview"
		else
			@taskas = Taska.where(id: $cakna21)
			@vltrs = Vltr.where(taska_id: $cakna21)
			if params[:sch].present?
				@vltrs = @vltrs.where(taska_id: params[:taska_id]) unless params[:taska_id].blank?
				@vltrs = @vltrs.where('name LIKE ?', "%#{params[:sch_str].upcase}%") unless params[:sch_str].blank?
			end
		end

		# @taska = Taska.find(params[:id])
		# @vltrs = @taska.vltrs
	end

	def cknstd
		@taskas = Taska.where(id: $cakna21)
		k = Kid.where(taska_id: $cakna21)
		k1 = k.where(taska_id: [286,606,592]).where.not(classroom_id: nil) 
		k2 = k.where.not(taska_id: [286,606,592])
		@kids = k1.or(k2)
		if params[:sch].present?
			@kids = @kids.where('name LIKE ?', "%#{params[:sch_str].upcase}%") unless params[:sch_str].blank?
			@kids = @kids.where(taska_id: params[:taska_id]) unless params[:taska_id].blank?
		end
	end

	def lsctr
		@taskas = Taska.where(id: $cakna21)
	end

	def rptckn
		@taskas = Taska.where(id: $cakna21)
		k=Kid.where(taska_id: $cakna21)
		k1 = k.where(taska_id: [286,606,592]).where.not(classroom_id: nil) 
		k2 = k.where.not(taska_id: [286,606,592])
		@kids = k
		@vltrs = Vltr.where(taska_id: $cakna21)

		@parent_arr = []
		@kid_arr = []
		@kids.each do |kd|
			arr_tmp = []
			arr_tmp << kd.mic unless kd.mic.blank?
			arr_tmp << kd.fic unless kd.mic.blank?
			
			if !(@parent_arr.include? arr_tmp)
				@parent_arr << arr_tmp
				@kid_arr << kd.id
			end
		end

		## CHART DATA FOR PARENTS ##
		@kid_parents = Kid.where(id: @kid_arr)
		#Job Sector
		mmsct = @kid_parents.where.not(mmsct: nil).group(:mmsct).count
		ftsct = @kid_parents.where.not(ftsct: nil).group(:ftsct).count
		parentsct = mmsct.merge!(ftsct) { |k, o, n| o + n }
		# @parent_sct["Lain-lain"] = @parent_sct["Lain-lain"] + @parent_sct[nil]
		# @parent_sct = @parent_sct.reject {|k,v| k == nil}
		# parentsct["No Response"] = parentsct.delete nil
		# parentsct = parentsct.sort_by { |key| key }.to_h
		parent_sct = {
			"Anggota Kesihatan" => 0,
			"Anggota Keselamatan" => 0,
			"Perkhidmatan Sokongan" => 0,
			"Penjawat Awam" => 0,
			"Swasta" => 0,
			"Bekerja Sendiri/Tidak Bekerja" => 0
		}
		parentsct.each do |k,v|
			if (k == "Perkhidmatan Sokongan(HR/Admin/Kewangan/IT)")
				parent_sct["Perkhidmatan Sokongan"] = v
			elsif (k == "Lain-lain")
				parent_sct["Bekerja Sendiri/Tidak Bekerja"] = v
			elsif !parent_sct.has_key?(k)
				parent_sct["Perkhidmatan Sokongan"] += 1
			else
				parent_sct[k] = v
			end
			
		end
		@parent_sct = crtchart(parent_sct)
		# tot = parentsct.values.sum.to_f
		# parentsct.each do |k,v|
		# 	@parent_sct["#{k} [#{v}, #{(v/tot*100).round(1)}%]"] = v
		# end


		#Job Gred
		mmgrd = @kid_parents.where.not(mmgrd: nil).group(:mmgrd).count
		ftgrd = @kid_parents.where.not(ftgrd: nil).group(:ftgrd).count
		parentgrd = mmgrd.merge!(ftgrd) { |k, o, n| o + n }
		# @parent_grd["Lain-lain"] = @parent_grd["Lain-lain"] + @parent_grd[nil]
		# @parent_grd = @parent_grd.reject {|k,v| k == nil}
		# parentgrd["No Response"] = parentgrd.delete nil
		parentgrd = parentgrd.sort_by { |key| key }.to_h
		parentgrd["Bekerja Sendiri/Tidak Bekerja"] = parentgrd.delete "Lain-lain"
		@parent_grd = crtchart(parentgrd)
		# tot = parentgrd.values.sum.to_f
		# parentgrd.each do |k,v|
		# 	@parent_grd["#{k} [#{v}, #{(v/tot*100).round(1)}%]"] = v
		# end

		#Monthly Household Income
		parentincome = @kid_parents.group(:income).count

		parent_inc = {
			"Below RM2,500"=>0, 
			"RM2,500 - RM4,849"=>0, 
			"RM4,850 - RM7,099"=>0, 
			"RM7,100 - RM10,959"=>0,
			"RM10,960 - RM15,039"=>0, 
			"Above RM15,040"=>0
		}
		parentincome.each do |k,v|
			if parent_inc.has_key?(k)
				parent_inc[k] = v
			else
				parent_inc["RM2,500 - RM4,849"] += 1
			end
		end
		@parent_income = crtchart(parent_inc)
		# tot = parent_inc.values.sum.to_f
		# parent_inc.each do |k,v|
		# 	@parent_income["#{k} [#{v}, #{(v/tot*100).round(1)}%]"] = v
		# end


		## CHART DATA FOR VOLUNTEERS
		#Gender
		vltrgender = @vltrs.group(:gender).count
		# @vltr_gender = {"FEMALE" => 0, "MALE" => 0}
		# @vltr_gender["FEMALE"] = vltrgender["FEMALE"]
		# @vltr_gender["MALE"] = vltrgender["MALE"]
		@vltr_gender = crtchart(vltrgender)
		# tot = vltrgender.values.sum.to_f
		# vltrgender.each do |k,v|
		# 	@vltr_gender["#{k} [#{v}, #{(v/tot*100).round(1)}%]"] = v
		# end

		#Marital Status
		vltrmarr = @vltrs.group(:marr).count
		@vltr_marr = {}
		tot = vltrmarr.values.sum.to_f
		vltrmarr.each do |k,v|
			@vltr_marr["#{k} [#{v}, #{(v/tot*100).round(1)}%]"] = v
		end
		#Education
		vltredu = @vltrs.group(:edu).count
		vltr_edu = {
			"PHD" => 0,
      "Master" => 0, 
      "Degree" => 0,
      "Diploma" => 0,
      "STPM" => 0,
      "SPM/SPMV/MCE/O-Level" => 0,
      "Sijil Kemahiran" => 0,
      "Others" => 0
		}
		vltredu.each do |k,v|
			vltr_edu[k] = v
		end
		@vltr_edu = crtchart(vltr_edu)
		# vltredu.each do |k,v|
		# 	@vltr_edu["#{k} [#{v}]"] = v
		# end

		## CHART DATA FOR KIDS
		#Gender
		kidgender = @kids.group(:gender).count
		@kid_gender = crtchart(kidgender)
		# kidgender.each do |k,v|
		# 	@kid_gender["#{k} [#{v}]"] = v
		# end

		#Age
		kidage = {
			"Less than 1 year old" => 0,
			"1 to 3 years old" => 0,
			"3 to 5 years old" => 0,
			"5 to 7 years old" => 0,
			"More than 7 years old" => 0
		}
		dt = Date.today
		@kids.each do |kd|
			age = ((dt - kd.dob).to_f)/365
			if age < 1
				kidage["Less than 1 year old"] += 1
			elsif (age >= 1) && (age < 3) 
				kidage["1 to 3 years old"] += 1
			elsif (age >= 3) && (age < 5) 
				kidage["3 to 5 years old"] += 1
			elsif (age >= 5) && (age < 7) 
				kidage["5 to 7 years old"] += 1
			elsif age >= 7
				kidage["More than 7 years old"] += 1
			end		
		end

		@kid_age = crtchart(kidage)
		# kidage.each do |k,v|
		# 	@kid_age["#{k} [#{v}]"] = v
		# end
		
		#OKU
		kidoku = @kids.where.not(oku: nil).group(:oku).count
		# kidoku["No Response"] = kidoku.delete nil
		kid_oku = {
			"No" => kidoku["No"],
			"Yes (with OKU Card)" => kidoku["Yes (Has OKU Card/Ada Kad OKU)"],
			"Yes (pending OKU Card)" => kidoku["Yes (Pending OKU Card/Dalam proses Mendapatkan Kad OKU)"]
		}

		# @kid_oku = crtchart(kid_oku) --> activate balik bila banyak center
		@kid_oku = kid_oku
		# kidoku.each do |k,v|
		# 	@kid_oku["#{k} [#{v}]"] = v
		# end

		if params[:pdf].present?
			respond_to do |format|
		 		format.html
		 		format.pdf do
			   render pdf: "Report",
			   template: "pages/rptckn.html.erb",
			   #disposition: "attachment",
			   zoom: 0.8,
			   page_size: "A4",
			   orientation: "portrait",
			   layout: 'pdf1.html.erb'
				end
			end
		end

	end

	def cakna21
	end

	def undiptns

	end

	def check_ptns
		ada_ic = $undiptns.include? params[:sch_str]
		if ada_ic
			flash[:success] = "Anda layak untuk mengundi. Sila klik link dibawah untuk mengundi"
			redirect_to undiptns_path(ic_val: 1)
			# sleep 1.5
			# redirect_to ENV['FORMPTNS']
		else
			flash[:danger] = "No MYKAD anda tiada dalam rekod kelayakan mengundi"
			redirect_to request.referrer
		end
		
	end

	def kap
		redirect_to "https://www.kidcare.my/newtchdetail?id=72&nwt=true"
	end

	def index
	end

	def tutorial
	end

	def tryroo
		@classroom = Classroom.all
		@taska = Taska.all
	end

	def uploadroo
		xlsx = Roo::Spreadsheet.open(params[:file])
		header = xlsx.row(xlsx.first_row)
		((xlsx.first_row+1)..(xlsx.last_row)).each do |n|
		xlsx.row(n)
		row = Hash[[header, xlsx.row(n)].transpose]
			Classroom.create(classroom_name: row["NAME"], taska_id: row["TASKA"], base_fee: row["BASE FEE"])
		end
		flash[:success] = "FILE UPLOADED"
		redirect_to tryroo_path
	end

	

	def sendgrid
		mail = SendGrid::Mail.new
		mail.from = SendGrid::Email.new(email: 'do-not-reply@kidcare.my', name: 'KidCare')
		mail.subject = 'Test'
		#Personalisation, add cc
		personalization = SendGrid::Personalization.new
		personalization.add_to(SendGrid::Email.new(email: 'mmnr00@gmail.com', name: 'MUS'))
		personalization.add_cc(SendGrid::Email.new(email: 'admin@kidcare.my', name: 'Example User'))
		mail.add_personalization(personalization)
		#add content
		taska = Taska.find(1)
		msg = "<html>
						<body>
							<strong>#{taska.name}</strong>
						</body>
					</html>"
		#sending email
		mail.add_content(SendGrid::Content.new(type: 'text/html', value: "#{msg}"))
		sg = SendGrid::API.new(api_key: ENV['SENDGRID_PASSWORD'])
		@response = sg.client.mail._('send').post(request_body: mail.to_json)
	end

	def about
	end

	def button
	end

	def charts
	end

	def icons
	end

	def invoice
	end
	
	def dashboard_v1
	end

	def tables
	end

	def bs_profile
	end

	def profile_card
	end

	def profile_card_edit
	end

	def pricing
	end

	def admin_card
		@taska = Taska.first
		render action: "admin_card", layout: "dsb-admin-classroom"
	end

	def team_cards
	end

	def classroom_card
		@taska = Taska.first
		render action: "classroom_card", layout: "dsb-admin-classroom"
	end

	# start PTNSSP 
	def ptns_sp
	end

	def ptns_sp_reg
		@ptnssp = Ptnssp.new
		@ptnssp.name = params[:ptnssp][:name]
		@ptnssp.strgh = params[:ptnssp][:strgh]
		@ptnssp.wkns = params[:ptnssp][:wkns]
		@ptnssp.opp = params[:ptnssp][:opp]
		@ptnssp.thr = params[:ptnssp][:thr]
		if @ptnssp.save
			flash[:success]= "Cadangan anda telah direkodkan. Sila pilih dari senarai dibawah untuk membuat perubahan"
			redirect_to ptns_sp_list_path
		end
	end

	def ptns_sp_list
		@ptnssp_list = Ptnssp.all.order('updated_at DESC')
	end

	def sms

		@client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_KEY"])

		@client.messages.create(
			to: "+60174151556",
			from: ENV["TWILIO_PHONE_NO"],
			body: "Mus try from Rails. Please click here #{root_url}"

		)

	end

	

	# end PTNS SP

	def bank_status
		#@taska_super = Taska.all.order('bank_status ASC').order('billplz_reg ASC')
		#@taska_super = Admin.last.taskas.order('bank_status ASC').order('billplz_reg ASC')
		@taska_check = Taska.all #kena tukar balik in prod to taska all
		@taska_verify = @taska_check.where.not(bank_status: "verified")
		@taska_verify.each do |taska|
			url_bill = "#{ENV['BILLPLZ_API']}check/bank_account_number/#{taska.acc_no}"
	    data_billplz = HTTParty.get(url_bill.to_str,
	            :body  => { }.to_json, 
	                        #:callback_url=>  "YOUR RETURN URL"}.to_json,
	            :basic_auth => { :username => ENV['BILLPLZ_APIKEY'] },
	            :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
	    #render json: data_billplz and return
	    data = JSON.parse(data_billplz.to_s)
	    if data["name"] != "not found"
	      taska.bank_status = data["name"]
	      taska.save
    	end
	  end
		@taska_super = Taska.all.where(collection_id: nil).includes(:payments).order("payments.paid ASC").order('bank_status DESC').order('billplz_reg ASC')
	end

	def billplz_reg
		taska = Taska.find(params[:id])
		taska.billplz_reg = "YES"
		taska.save
		redirect_to bank_status_path
	end

	private

	def crtchart(hash_data)
		puts "This IS ----->>>> #{hash_data}"
		new_hash = {}
		tot = 0.00
		tot = hash_data.values.sum.to_f
		hash_data.each do |k,v|
			new_hash["#{k} [#{v}, #{(v/tot*100).round(1)}%]"] = v
		end
		return new_hash
	end

	def set_all
    @teacher = current_teacher
    @parent = current_parent
    @admin = current_admin  
    @owner = current_owner
  end

  def checkadmckn
		if (!$admckn.include? @admin.id.to_s)
			flash[:danger] = "You dont have access"
			redirect_to admin_index_path
		end
	end

  def superadmin
		if ((!current_admin) || (current_admin != Admin.first))
			flash[:danger] = "You dont have access"
			redirect_to root_path
		end
  end

end