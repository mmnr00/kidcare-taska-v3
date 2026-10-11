desc "Send waba rake"
task wabark: :environment do
	Taska.where.not(waba: nil).each do |t|
		arr = []
		t.waba.each do |v|
			to = v[0]
			notftype = v[1]
			pmt = v[2]
			tsk = v[3]
			type = v[4]
			
			if (Payment.where(id: pmt, paid: false).present?) && (!arr.include? [to,notftype,pmt,tsk,type])
				payment = Payment.find(pmt)
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
			  sleep 1.0
			  # data = JSON.parse(data_isms_waba.to_s)
			  # puts data
			  # sleep 0.5
			  # payment.waba << [Time.now,notftype,data["messageId"],to]
			  # payment.fin = true
			  # payment.save
			  begin 
				  data = JSON.parse(data_isms_waba.to_s)
				  puts data
				  # sleep 0.5
				  sleep 1.0
				  payment.waba << [Time.now,notftype,"#{data["messageId"]} AND #{data["requestId"]} ",to]
				  payment.fin = true
				  payment.save
				  arr << [to,notftype,pmt,tsk,type]
				  puts arr
				  puts "complete"
				rescue JSON::ParserError => e
					puts "Skipping #{e.message}"
				end
			end
		  
		end
		t.waba = nil
		t.save
		puts "#{t.name}"
	end
      
	puts "wabark"
end