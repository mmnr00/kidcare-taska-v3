desc "Try Scheduling"
task try_sch: :environment do
	
	url = "https://sms.360.my/gw/bulk360/v1.4?"
  usr = "user=admin@kidcare.my&"
  ps = "pass=#{ENV['SMS360']}&"
  txt = "text=Schedule successful on #{Time.now}"

  to = "to=60174151556&"
  fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"
  data_sms = HTTParty.get("#{url}#{usr}#{ps}#{to}#{txt}",
                          http_proxyaddr: fixie.host,
                          http_proxyport: fixie.port,
                          http_proxyuser: fixie.user,
                          http_proxypass: fixie.password,
                          timeout: 120)

end