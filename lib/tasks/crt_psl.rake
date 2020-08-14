desc "Create Payslip"
task crt_psl: :environment do
	bl_dt = Time.now
	dy = bl_dt.day
	mth = bl_dt.month
	yr = bl_dt.year 
	email_par = {} #{Taska ID => [[pmt_id,[kid_ids]]]}

	url = "https://sms.360.my/gw/bulk360/v1.4?"
  usr = "user=admin@kidcare.my&"
  ps = "pass=#{ENV['SMS360']}&"
  fixie = URI.parse "http://fixie:2lSaDRfniJz8lOS@velodrome.usefixie.com:80"

  Taska.where(psldt: dy).each do |tsk|
  	sms_par = {} #{Taska ID => [[pmt_id,[kid_ids]]]}
  	psl_cnt = 0
  	tsk.classrooms.each do |cls|
  		puts "Classroom Name: #{cls.classroom_name}"
  		cls.teachers.where(id: 115).each do |tch|; if tch.payslips.where(mth: mth, year: yr).blank?
  			pi = tch.payinfos.first
  			amt = 0.00
  			amta = 0.00
  			tot = pi.amt + pi.alwnc 
  			amt = tot - pi.epf - pi.socs - pi.sip - pi.fxddc  
  			amta = tot + pi.epfa + pi.socsa + pi.sipa
  			puts "Amt= #{amt}"
  			puts "Amta= #{amta}"
  			psl = Payslip.new(mth: mth, year: yr, amt: tot,
  												alwnc: pi.alwnc, epf: pi.epf,
  												epfa: pi.epfa, amtepfa: amta,
  												socs: pi.socs, socsa: pi.socsa,
  												sip: pi.sip, sipa: pi.sipa, fxddc: pi.fxddc,
  												taska_id: tsk.id, teacher_id: tch.id, xtra: "")
  			psl.save
  			psl.id
  			psl_cnt += 1
  		end; end
  	end #classroom

  	#send sms to admin

  end #taska

  #send email to Mus

end #task


