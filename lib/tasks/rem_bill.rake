desc "Bill Reminder"
task rem_bill: :environment do
	dy = Time.now.day
	url = "https://www.isms.com.my/isms_send.php?"
  usr = "un=admin_kidcare&"
  ps = "pwd=#{ENV['isms']}&"
  tp = "type=1&"
  trm = "agreedterm=YES"
  fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"
  email_par = {} #{Taska ID => [[ph1,kid_id1,payment_id,stat],[ph2,kid_id2,payment_id2,stat]]}

	Taska.where(remdt: dy).each do |tsk|
		if tsk.expire > (Date.today - 1.days)
			email_par[tsk.id] = []
			unpaid_remd2 = tsk.payments.where(name: "KID BILL",paid: false,reminder: false, fin: true)

			unpaid_remd2.each do |pm|
				payment = Payment.find(pm.id) 
				#check payment status
				if !payment.paid #&& Rails.env.production?
					url_bill = "#{ENV['BILLPLZ_API']}bills/#{payment.bill_id2}"
		      data_billplz = HTTParty.get(url_bill.to_str,
		              :body  => { }.to_json, 
		                          #:callback_url=>  "YOUR RETURN URL"}.to_json,
		              :basic_auth => { :username => "#{ENV['BILLPLZ_APIKEY']}" },
		              :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
		      #render json: data_billplz and return
		      data = JSON.parse(data_billplz.to_s)
		      if data["id"].present? && (data["paid"] == true)
		      	payment.paid = data["paid"]
		      	payment.mtd = "BILLPLZ"
		      	payment.updated_at = data["paid_at"]
		      	payment.save
		      end
				end
			end


			unpaid_remd = tsk.payments.where(name: "KID BILL",paid: false,reminder: false, fin: true)

			unpaid_remd.each do |pmt|; if pmt.parpayms.blank?
				kd = pmt.kids.first
				# ph = "#{kd.ph_1}#{kd.ph_2}"
				# to = "dstno=6#{ph}&"
				# log = [ph,kd.id,pmt.id]
	   #    txt = "msg=Reminder from #{tsk.name.upcase}. Please click here <https://www.kidcare.my/billview?pmt=#{pmt.id}> to pay&"
				# # puts "#{ph}-#{kd.id}"
				# # puts txt
				# data_sms = nil
				# data_sms = HTTParty.get("#{url}#{usr}#{ps}#{to}#{txt}#{tp}#{trm}", timeout: 120)
	   #  	puts data_sms

	   		if kd.ph_1.include? "+"
          to = "#{kd.ph_1.delete! '+'}#{kd.ph_2}"
        else
          to = "6#{kd.ph_1}#{kd.ph_2}"
        end
        
        #data_sms = nil

        #data_sms = HTTParty.get("#{url}#{usr}#{ps}#{to}#{txt}#{tp}#{trm}", timeout: 120)

        data_isms_waba = HTTParty.post("https://ww3.isms.com.my/isms_send_waba.php",
                  :body=> { :AppId => ENV['WABA_APPID'], 
                  :AppSecret=> ENV['WABA_APP_SECRET'],
                  :un=> "kidcarewaba", 
                  :pwd=> ENV['WABA_PWD'],
                  :agreedterm=> "YES",
                  :Type=> "template",
                  :TemplateCode=> ENV['WABA_TMP_REMD'],
                  :TemplateParams=> {:billurl => "https://www.kidcare.my/billview?pmt=#{pmt.id}",:centername => "#{tsk.name}"},
                  :Language=> "en",
                  :From=> ENV['WABA_PH'],
                  :To=> to}.to_json,
                  :basic_auth => {},
            :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
        data = JSON.parse(data_isms_waba.to_s)
        puts data

				pmt.reminder = true unless data.blank?
				pmt.save
				if data_isms_waba.present?
					stat = data_isms_waba.parsed_response[0..2]
				else
					stat = "not sent"
				end
				log = [to,kd.id,pmt.id,stat]
				email_par[tsk.id] << log
			end; end #payment

			#send sms to admin
			to = "to=6#{tsk.phone_1}#{tsk.phone_2}&"
	    txt = "text=[KIDCARE] #{email_par[tsk.id].count} SMS reminders successfully sent for #{tsk.name.upcase} on #{Time.now.strftime('%d-%^b-%y')} at #{Time.now.strftime('%I:%m %p')}"
			# puts txt
			#data_sms = HTTParty.get("#{url}#{usr}#{ps}#{to}#{txt}",http_proxyaddr: fixie.host,http_proxyport: fixie.port,http_proxyuser: fixie.user,http_proxypass: fixie.password,timeout: 120)
		end #expire
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


