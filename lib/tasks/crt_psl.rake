desc "Create Payslip"
task crt_psl: :environment do
	bl_dt = Time.now
	dy = bl_dt.day
	mth = bl_dt.month
	yr = bl_dt.year 
	email_par = {} #{Taska ID => [[psl_id,tch_id]]}

	url = "https://sms.360.my/gw/bulk360/v1.4?"
  usr = "user=admin@kidcare.my&"
  ps = "pass=#{ENV['SMS360']}&"
  fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"

  Taska.where(psldt: dy).each do |tsk|
  	psl_cnt = 0
  	email_par[tsk.id] = []
  	tsk.classrooms.each do |cls|
  		cls.teachers.each do |tch|; if tch.payslips.where(mth: mth, year: yr).blank?
  			pi = tch.payinfos.first
  			amt = 0.00
  			amta = 0.00
  			tot = pi.amt + pi.alwnc 
  			amt = tot - pi.epf - pi.socs - pi.sip - pi.fxddc  
  			amta = tot + pi.epfa + pi.socsa + pi.sipa
  			# puts "Amt= #{amt}"
  			# puts "Amta= #{amta}"
        unq = [*('a'..'z'),*('0'..'9')].shuffle[0,8].join
        while Payslip.where(psl_id: unq).present?
          unq = [*('a'..'z'),*('0'..'9')].shuffle[0,8].join
        end
  			psl = Payslip.new(mth: mth, year: yr, amt: tot,
  												alwnc: pi.alwnc, epf: pi.epf,
  												epfa: pi.epfa, amtepfa: amta,
  												socs: pi.socs, socsa: pi.socsa, psl_id: unq,
  												sip: pi.sip, sipa: pi.sipa, fxddc: pi.fxddc,
  												taska_id: tsk.id, teacher_id: tch.id, xtra: "")
  			if psl.save
	  			psl_cnt += 1
	  			email_par[tsk.id] << [psl.id,tch.id]
	  		end
  		end; end
  	end #classroom

  	#send sms to admin
  	puts "#{psl_cnt} payslip(s) AUTOMATICALLY created for #{tsk.name}"
  	to = "to=6#{tsk.phone_1}#{tsk.phone_2}&"
    txt = "text=[KIDCARE] #{psl_cnt} payslip(s) AUTOMATICALLY created for #{tsk.name}"
		data_sms = HTTParty.get(
                      "#{url}#{usr}#{ps}#{to}#{txt}",
                      http_proxyaddr: fixie.host,
                      http_proxyport: fixie.port,
                      http_proxyuser: fixie.user,
                      http_proxypass: fixie.password,
                      timeout: 120)
  end #taska

  #send email to Mus
  list_sms = ""
	email_par.each do |k,v|
		t= Taska.find(k)
		tsk_list = "<h4>#{t.name} (#{k}) - #{v.count}</h4>
								<ol>"
		sms_list = ""
		v.each do |sms|
			sms_list = sms_list + 
								"<li>
									PSL ID=#{sms[0]}; #{Teacher.find(sms[1]).tchdetail.name} (#{sms[1]})
								</li>
								"
		end
		list_sms = list_sms + tsk_list + sms_list + "</ol>"
	end

	mail = SendGrid::Mail.new
  mail.from = SendGrid::Email.new(email: 'do-not-reply@kidcare.my', name: 'KidCare')
  mail.subject = "CREATE PAYSLIP ROBOT - #{Time.now}"
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

  puts email_par
  #Payslip.where(mth: 8,year: 2020).delete_all
end #task


