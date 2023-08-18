class PayslipsController < ApplicationController

	def cfmpsl
		@payslip = Payslip.find(params[:psl])
		mth = @payslip.mth
    yr = @payslip.year
    tsk = @payslip.taska
    tch = @payslip.teacher
    tchd = tch.tchdetail
		@payslip.notf = 1
		@payslip.save
		#sent email
		mail = SendGrid::Mail.new
    mail.from = SendGrid::Email.new(email: 'notification@kidcare.my', name: 'KidCare')
    mail.subject = "NEW PAYSLIP FOR #{$month_name[mth]}-#{yr}"
    #Personalisation, add cc
    personalization = SendGrid::Personalization.new
    personalization.add_to(SendGrid::Email.new(email: "#{tch.email}"))
    personalization.add_cc(SendGrid::Email.new(email: "#{tsk.email}"))
    mail.add_personalization(personalization)
    #add content
    msg = "<html>
            <body>
              Hi <strong>#{tchd.name.upcase}</strong><br><br>


              <strong>#{tsk.name.upcase}</strong> had created your payslip for <strong>#{$month_name[mth]}-#{yr}</strong>.<br>
              <br>

              Please login to view.<br> 

              Many thanks for your continous support.<br><br>

              Powered by <strong>www.kidcare.my</strong>
            </body>
          </html>"
    #sending email
    mail.add_content(SendGrid::Content.new(type: 'text/html', value: "#{msg}"))
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_PASSWORD'])
    @response = sg.client.mail._('send').post(request_body: mail.to_json)

		flash[:success] = "Payslip confirmed and email sent to #{tch.email} (#{tchd.name})"
		redirect_to request.referrer
	end

	def viewpsl
		@admin = current_admin
		@payslip = Payslip.find(params[:psl])
		@teacher = @payslip.teacher
		@taska = @payslip.taska
	end

	def pdfpsl
		@pdf = true
		@admin = current_admin
		@payslip = Payslip.find(params[:psl])
		@teacher = @payslip.teacher
		@taska = @payslip.taska
		respond_to do |format|
	 		format.html
	 		format.pdf do
		   render pdf: "Payslip",
		   template: "payslips/pdfpsl.html.erb",
		   #disposition: "attachment",
		   page_size: "A4",
		   zoom: 0.8,
		   #orientation: "landscape",
		   layout: 'pdf.html.erb',
		   encoding: "UTF-8"
			end
		end
	end

	def dltpsl
		@payslip = Payslip.find(params[:psl])
		tch_id = @payslip.teacher.id
		tsk_id = @payslip.taska.id
		mthpsl = @payslip.mth
		yrpsl = @payslip.year
		if @payslip.destroy
			flash[:success] = "DELETION SUCCESSFUL"
		else
			flash[:danger] = "DELETION FAILED. PLEASE TRY AGAIN"
		end
		if params[:allpsl] == "true"
			redirect_to taskateachers_path(id: tsk_id,
                                    tb7_a: params[:tb7_a],
                                    tb7_ar: params[:tb7_ar],
                                    tb7_d: params[:tb7_d],
                                    mthpsl: mthpsl,
                                    yrpsl: yrpsl)
		else
			redirect_to tchpayslip_path(id: tsk_id, tch_id: tch_id)
		end
	end

end