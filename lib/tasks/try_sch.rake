desc "Try Scheduling"
task try_sch: :environment do
	
	# url = "https://sms.360.my/gw/bulk360/v1.4?"
 #  usr = "user=admin@kidcare.my&"
 #  ps = "pass=#{ENV['SMS360']}&"
 #  txt = "text=Schedule successful on #{Time.now}"

 #  to = "to=60174151556&"
 #  fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"
 #  data_sms = HTTParty.get("#{url}#{usr}#{ps}#{to}#{txt}",
 #                          http_proxyaddr: fixie.host,
 #                          http_proxyport: fixie.port,
 #                          http_proxyuser: fixie.user,
 #                          http_proxypass: fixie.password,
 #                          timeout: 120)

 #SEND EMAIL
  mail = SendGrid::Mail.new
  mail.from = SendGrid::Email.new(email: 'do-not-reply@kidcare.my', name: 'KidCare')
  mail.subject = "Try email schedule"
  #Personalisation, add cc
  personalization = SendGrid::Personalization.new
  personalization.add_to(SendGrid::Email.new(email: "mustakhim@kidcare.my"))
  personalization.add_cc(SendGrid::Email.new(email: "mmnr00@gmail.com"))
  mail.add_personalization(personalization)
  #add content
  msg = "<html>
          <body>
            Try Schedule from Rake
          </body>
        </html>"
  #sending email
  mail.add_content(SendGrid::Content.new(type: 'text/html', value: "#{msg}"))
  sg = SendGrid::API.new(api_key: ENV['SENDGRID_PASSWORD'])
  @response = sg.client.mail._('send').post(request_body: mail.to_json)

end