#TESTING ISMS
url = "https://www.isms.com.my/isms_send.php?"
usr = "un=admin_kidcare&"
ps = "pwd=#{ENV['isms']}&"
txt = "msg=Hi Mus ni isms&"
to = "dstno=60174151556&"
tp = "type=1&"
trm = "agreedterm=YES"
fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"
data_sms = nil

data_sms = HTTParty.get("#{url}#{usr}#{ps}#{to}#{txt}#{tp}#{trm}")

#REAL ISMS
url = "https://www.isms.com.my/isms_send.php?"
usr = "un=admin_kidcare&"
ps = "pwd=#{ENV['isms']}&"
txt = "msg=Reminder from #{@taska.name.upcase}. Please click here <#{billview_url(pmt: @payment.id)}> to payment&"
to = "dstno=6#{phk}&"
tp = "type=1&"
trm = "agreedterm=YES"
data_sms = nil

data_sms = HTTParty.get("#{url}#{usr}#{ps}#{to}#{txt}#{tp}#{trm}", timeout: 120)

# OLD SMS 360
url = "https://sms.360.my/gw/bulk360/v1.4?"
usr = "user=admin@kidcare.my&"
ps = "pass=#{ENV['SMS360']}&"
to = "to=6#{phk}&"
txt = "text=Reminder from #{@taska.name.upcase}. Please click here <#{billview_url(pmt: @payment.id)}> to payment"
fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"
data_sms = nil

data_sms = HTTParty.get("#{url}#{usr}#{ps}#{to}#{txt}",
                        http_proxyaddr: fixie.host,
                        http_proxyport: fixie.port,
                        http_proxyuser: fixie.user,
                        http_proxypass: fixie.password,
                        timeout: 120)