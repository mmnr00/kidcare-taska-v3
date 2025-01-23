desc "Send waba rake"
task wabark: :environment do
	Taska.where.not(waba: nil).each do |t|
		t.waba.each do |v|
			to = v[0]
			notftype = v[1]
			pmt = v[2]
			tsk = v[3]
			type = v[4]
			payment = Payment.find(pmt)
			if payment.present?
			  msgtype = {"remd" => ENV['WABA_TMP_REMD'], "new" => ENV['WABA_TMP_BILL']}
			  data_isms_waba = HTTParty.post("https://ww3.isms.com.my/isms_send_waba.php",
			                :body=> { :AppId => ENV['WABA_APPID'], 
			                :AppSecret=> ENV['WABA_APP_SECRET'],
			                :un=> "kidcarewaba", 
			                :pwd=> ENV['WABA_PWD'],
			                :agreedterm=> "YES",
			                :Type=> "template",
			                :TemplateCode=> msgtype[type],
			                :TemplateParams=> {:billurl => "https://www.kidcare.my/billview?pmt=#{pmt}",:centername => "#{tsk}"},
			                :Language=> "en",
			                :From=> ENV['WABA_PH'],
			                :To=> to}.to_json,
			                :basic_auth => {},
			          :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
			  data = JSON.parse(data_isms_waba.to_s)
			  puts data
			  sleep 0.5
			  
			  payment.waba << [Time.now,notftype,data["messageId"],to]
			  payment.fin = true
			  payment.save
			end
		  
		end
		t.waba = nil
		t.save
		puts "#{t.name}"
	end
      
	puts "wabark"
end