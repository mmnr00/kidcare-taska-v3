desc "Bill Reminder"
task rem_bill: :environment do
	dy = Time.now.day
	url = "https://sms.360.my/gw/bulk360/v1.4?"
  usr = "user=admin@kidcare.my&"
  ps = "pass=#{ENV['SMS360']}&"
  fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"
  email_par = {} #{Taska ID => [[ph1,kid_id1,payment_id,stat],[ph2,kid_id2,payment_id2,stat]]}

	Taska.where(remdt: dy).each do |tsk|
		email_par[tsk.id] = []
		unpaid_remd = tsk.payments.where(name: "KID BILL",paid: false,reminder: false)

		unpaid_remd.each do |pmt|; if pmt.parpayms.blank?
			kd = pmt.kids.first
			ph = "#{kd.ph_1}#{kd.ph_2}"
			to = "to=6#{ph}&"
			log = [ph,kd.id,pmt.id]
      txt = "text=Reminder from #{tsk.name.upcase}. Please click here <https://www.kidcare.my/billview?pmt=#{pmt.id}> to pay"
			# puts "#{ph}-#{kd.id}"
			# puts txt
			data_sms = nil
			data_sms = HTTParty.get(
                        "#{url}#{usr}#{ps}#{to}#{txt}",
                        http_proxyaddr: fixie.host,
                        http_proxyport: fixie.port,
                        http_proxyuser: fixie.user,
                        http_proxypass: fixie.password,
                        timeout: 120)
			pmt.reminder = true unless data_sms.blank?
			pmt.save
			if data_sms.present?
				stat = data_sms.parsed_response[0..2]
			else
				stat = "not sent"
			end
			log = [ph,kd.id,pmt.id,stat]
			email_par[tsk.id] << log
		end; end #payment

		#send sms to admin
		to = "to=6#{tsk.phone_1}#{tsk.phone_2}&"
    txt = "text=[KIDCARE] #{email_par[tsk.id].count} SMS reminders successfully sent for #{tsk.name.upcase} on #{Time.now.strftime('%d-%^b-%y')} at #{Time.now.strftime('%I:%m %p')}"
		# puts txt
		data_sms = HTTParty.get(
                      "#{url}#{usr}#{ps}#{to}#{txt}",
                      http_proxyaddr: fixie.host,
                      http_proxyport: fixie.port,
                      http_proxyuser: fixie.user,
                      http_proxypass: fixie.password,
                      timeout: 120)

	end #taska

	#send log to Mus
	puts email_par

	#write email body
	list_sms = ""
	email_par.each do |k,v|
		t= Taska.find(k)
		tsk_list = "<h4>#{t.name} (#{k}) - #{v.count}</h4>
								<ol>"
		sms_list = ""
		v.each do |sms|
			sms_list = sms_list + 
								"<li>
									Ph No=#{sms[0]};Kid Id=#{sms[1]};Pmt Id=#{sms[2]};Stat=#{sms[3]};
								</li>
								"
		end
		list_sms = list_sms + tsk_list + sms_list + "</ol>"
	end

	mail = SendGrid::Mail.new
  mail.from = SendGrid::Email.new(email: 'do-not-reply@kidcare.my', name: 'KidCare')
  mail.subject = "SMS REMINDER ROBOT - #{Time.now}"
  #Personalisation, add cc
  personalization = SendGrid::Personalization.new
  personalization.add_to(SendGrid::Email.new(email: "mustakhim@kidcare.my"))
  personalization.add_cc(SendGrid::Email.new(email: "mmnr00@gmail.com"))
  mail.add_personalization(personalization)
  #add content
  msg = "<html>
          <body>
            #{list_sms}
          </body>
        </html>"
  #sending email
  mail.add_content(SendGrid::Content.new(type: 'text/html', value: "#{msg}"))
  sg = SendGrid::API.new(api_key: ENV['SENDGRID_PASSWORD'])
  @response = sg.client.mail._('send').post(request_body: mail.to_json)


end #task

