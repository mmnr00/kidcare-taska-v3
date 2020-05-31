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
		@taska = @dcov.taska
		@kid = @dcov.kid
		flash[:success] = "Health Status Updated"
		if (@dcov.temp > 100) || (@dcov.cond.include? "Yes") || (@dcov.cond[5].present?)

			msg = 
			"<html>
				<body>
				Health Alert Notification
				</body>
				</html>"

			#sending email
			mail = SendGrid::Mail.new
			mail.from = SendGrid::Email.new(email: 'alert@kidcare.my', name: "KidCare Health Alert")
			mail.subject = "Health Status Alert for #{@kid.name}"
			#Personalisation, add cc
			personalization = SendGrid::Personalization.new
			@dcov.taska.admins.where.not(id: 4).each do |adm|
				personalization.add_to(SendGrid::Email.new(email: "#{adm.email}"))
			end
			mail.add_personalization(personalization)
			mail.add_content(SendGrid::Content.new(type: 'text/html', value: "#{msg}"))
			sg = SendGrid::API.new(api_key: ENV['SENDGRID_PASSWORD'])
			@response = sg.client.mail._('send').post(request_body: mail.to_json)


			

		end
		
	end



	private

	def dcov_params
	end

end