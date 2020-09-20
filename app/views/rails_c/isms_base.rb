url = "https://www.isms.com.my/isms_send.php?"
usr = "un=admin_kidcare&"
ps = "pwd=kidCare@123&"
txt = "msg=Hi Mus ni isms&"
to = "dstno=60174151556&"
tp = "type=1&"
trm = "agreedterm=YES"
fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"
data_sms = nil

data_sms = HTTParty.get("#{url}#{usr}#{ps}#{to}#{txt}#{tp}#{trm}")

