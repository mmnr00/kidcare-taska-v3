desc "Create Monthly Bill"
task crt_bill: :environment do

	dy = Time.now.day
	bl_dt = Time.now + 1.months
	mth = bl_dt.month
	yr = bl_dt.year 
	email_par = {} #{Taska ID => [[pmt_id,[kid_ids]]]}
	url = "https://sms.360.my/gw/bulk360/v1.4?"
  usr = "user=admin@kidcare.my&"
  ps = "pass=#{ENV['SMS360']}&"
  fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"

	Taska.where(bldt: dy).each do |tsk|
		email_par[tsk.id] = []
		#init create Bill
		kids = tsk.kids.where.not(classroom_id: nil)

		#check if bill already exist
		kids.each do |kd|
			if kd.payments.where(bill_month: mth,bill_year: yr).blank?

				#init payment details
				amount = 0.00
				amount = amount + kd.classroom.base_fee
				kd.extras.each do |ext|
					amount += ext.price
				end 
				kd.beradik.each do |sb|
					amount = amount + sb.classroom.base_fee
					sb.extras.each do |ext|
						amount += ext.price
					end 
				end

				unq = (0...8).map { ('A'..'Z').to_a[rand(26)] }.join
	      while Payment.where(bill_id: unq).present?
	        unq = (0...8).map { ('A'..'Z').to_a[rand(26)] }.join
	      end

				#create payment 
				pmt = Payment.new(amount: amount,
													description: "NA",
													bill_month: mth,
													bill_year: yr,
													discount: 0,
													discdx: "",
													parent_id: kd.parent.id,
													taska_id: tsk.id,
													state: "due",
													paid: false,
													fin: false,
													bill_id: unq,
													reminder: false,
													name: "KID BILL",
													cltid: tsk.collection_id)
				pmt.save

				#create addition
				Addtn.create(desc: "",
												amount: 0,
												payment_id: pmt.id)

				#create kidbill
				kid_id = [kd.id]
				kd.beradik.each do |sb|
					kid_id << sb.id
				end
				Kid.where(id: kid_id).each do |kd|
					kb = KidBill.new(kid_id: kd.id,
													payment_id: pmt.id,
													kidname: kd.name,
													kidic: "#{kd.ic_1}-#{kd.ic_2}-#{kd.ic_3}",
													classroom_id: kd.classroom.id,
													clsname: kd.classroom.classroom_name,
													clsfee: kd.classroom.base_fee)
					cnt = 1
					kd.extras.each do |ext|
						kb.extra << ext.id
						extra = Extra.find(ext.id)
		        kb.extradtl["#{cnt}. #{extra.name}"] = extra.price
		        cnt = cnt + 1
					end
					kb.save
				end

				email_par[tsk.id] << [pmt.id,pmt.kids.ids]


			end	#no existing payment		
		end #kid

		#send sms to admin
		puts "#{$month_name[mth]}-#{yr} bills created for #{kids.count} kid(s)"
		to = "to=6#{tsk.phone_1}#{tsk.phone_2}&"
    txt = "text=[KIDCARE] #{$month_name[mth]}-#{yr} bills created for #{kids.count} kid(s) for #{tsk.name.upcase} on #{Time.now.strftime('%d-%^b-%y')} at #{Time.now.strftime('%I:%m %p')}"
		puts txt
		data_sms = HTTParty.get(
	                    "#{url}#{usr}#{ps}#{to}#{txt}",
	                    http_proxyaddr: fixie.host,
	                    http_proxyport: fixie.port,
	                    http_proxyuser: fixie.user,
	                    http_proxypass: fixie.password,
	                      timeout: 120)

	end #taska

	#write email body
	list_sms = ""
	email_par.each do |k,v|
		t= Taska.find(k)
		tsk_list = "<h4>#{t.name} (#{k}) - #{v.count} bills</h4>
								<ol>"
		sms_list = ""
		v.each do |sms|
			sms_list = sms_list + 
								"<li>
									Pmt_ID=#{sms[0]}
								"
			sms[1].each do |kid|
				sms_list = sms_list + ";#{Kid.find(kid).name}-(#{kid})"
			end
		end
		list_sms = list_sms + tsk_list + sms_list + "</ol>"
	end


	#send email to Mus
	mail = SendGrid::Mail.new
  mail.from = SendGrid::Email.new(email: 'do-not-reply@kidcare.my', name: 'KidCare')
  mail.subject = "BILL CREATION ROBOT #{Time.now}"
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







