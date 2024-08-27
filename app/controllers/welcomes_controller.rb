class WelcomesController < ApplicationController
	#before_action :authenticate_admin!
	before_action :allow_iframe_requests
	
	#layout "page"

	def trywasap

		#@admin = current_admin

		data_billplz = HTTParty.post("https://ww3.isms.com.my/isms_send_waba.php",
		              :body=> { :AppId => ENV['WABA_APPID'], 
		              :AppSecret=> ENV['WABA_APP_SECRET'],
		              :un=> "kidcarewaba", 
		              :pwd=> ENV['WABA_PWD'],
		              :agreedterm=> "YES",
		              :Type=> "template",
		              :TemplateCode=> ENV['WABA_TMP_BILL'],
		              :TemplateParams=> {:billurl => "https://www.kidcare.my ",:centername => "Kid Care Kuala Lumpur"},
		              :Language=> "en",
		              :From=> ENV['WABA_PH'],
		              :To=> "60174151556"}.to_json,
		              :basic_auth => {},
		    :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
		data = JSON.parse(data_billplz.to_s)
		puts data

	end

	def caknafeedback
		redirect_to "https://forms.gle/EE7LbsekSA8MHDK7A"
	end

	def payabesar
		redirect_to "https://forms.gle/oh86QEVx46QfTKrT9"
	end

	def cubakidcare
		redirect_to "https://docs.google.com/forms/d/e/1FAIpQLSd4JxRbj0HIubm_o1w0BjUUkebPFxJf8SwFzwT09f2QJCFUWw/viewform?usp=sf_link"
	end

	def cikgu_anis
		redirect_to "https://kidcare.my/ebook_anis.pdf"
	end

	def cmbr19
		@taska = Taska.find(params[:id])
	end

	def cmbr19pdf
		@pdf = true
		respond_to do |format|
	 		format.html
	 		format.pdf do
		   render pdf: "[MBR 2019] #{params[:name].upcase}",
		   template: "welcomes/cmbr19pdf.html.erb",
		   disposition: "attachment",
		   #page_size: "A6",
		   zoom: 0.65,
		   # margin: {top: 10,
		   # 					bottom: 5,
		   # 					left: 10,
		   # 					right: 10
		   # },
		   orientation: "portrait",
		   layout: 'pdf.html.erb'
			end
		end
	end

	def index
		
	end

	def index2
		if params[:anis].present?
			redirect_to daftaranis_path
			#redirect_to new_tchdetail_path(id: 70, anis: true)
		elsif params[:anis1].present?
			redirect_to new_tchdetail_path(id: 66, anis: true)
		elsif params[:anis2].present?
			redirect_to new_tchdetail_path(id: 68, anis: true, clse: 1)
		else
			@teacher = current_teacher
			@admin = current_admin
			@owner = current_owner
			@parent = current_parent
			render action: "index2", layout: "homepage2"
		end
		
	end

	def login
		#render action: "login", layout: "dashboard"
		if current_admin || current_teacher || current_parent
			if current_admin
				redirect_to admin_index_path
			elsif current_teacher
				redirect_to admin_index_path
			elsif current_parent
				redirect_to parent_index_path
			end
		end
	end

	def sb_dashboard

		render action: "sb_dashboard", layout: "dsb-admin-eg"

	end

	def sb_table
		#render action: "sb_table", layout: "dsb-admin-eg"
	end

	def star_rating
		render action: "star_rating", layout: "dsb-admin-eg"
	end



	private

	def allow_iframe_requests
  	response.headers.delete('X-Frame-Options')
	end

end
















