desc "Bill Reminder"
task rem_bill: :environment do
	dy = Time.now.day
	url = "https://sms.360.my/gw/bulk360/v1.4?"
  usr = "user=admin@kidcare.my&"
  ps = "pass=#{ENV['SMS360']}&"
  fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"

	Taska.where(remdt: dy).each do |tsk|

		unpaid_remd = tsk.payments.where(name: "KID BILL",paid: false,reminder: false)

		unpaid_remd.each do |pmt|
			kd = pmt.kids.first
			ph = "#{kd.ph_1}#{kd.ph_2}"
			to = "to=6#{ph}&"
      txt = "text=Reminder from #{tsk.name.upcase}. Please click here <https://www.kidcare.my/billview?pmt=#{pmt.id}> to pay"
			# puts "#{ph}-#{kd.id}"
			# puts txt
			data_sms = HTTParty.get(
                        "#{url}#{usr}#{ps}#{to}#{txt}",
                        http_proxyaddr: fixie.host,
                        http_proxyport: fixie.port,
                        http_proxyuser: fixie.user,
                        http_proxypass: fixie.password,
                        timeout: 120)
			pmt.reminder = true
			pmt.save
		end #payment

		#send sms to admin
		to = "to=6#{tsk.phone_1}#{tsk.phone_2}&"
    txt = "text=[KIDCARE] #{unpaid_remd.count} SMS reminders successfully sent for #{tsk.name.upcase} on #{Time.now.strftime('%d-%^b-%y')} at #{Time.now.strftime('%I:%m %p')}"
		# puts txt
		data_sms = HTTParty.get(
                      "#{url}#{usr}#{ps}#{to}#{txt}",
                      http_proxyaddr: fixie.host,
                      http_proxyport: fixie.port,
                      http_proxyuser: fixie.user,
                      http_proxypass: fixie.password,
                        timeout: 120)

	end #taska

end #task


