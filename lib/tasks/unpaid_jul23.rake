desc "Update unpaid Payment"
task unpaid_jul23: :environment do


Payment.where(name: "KID BILL", paid: false, bill_month: [5,6,7,8], bill_year: 2023).each do |payment|
	url_bill = "#{ENV['BILLPLZ_API']}bills/#{payment.bill_id2}"
	data_billplz = HTTParty.get(url_bill.to_str,
	        :body  => { }.to_json, 
	                    #:callback_url=>  "YOUR RETURN URL"}.to_json,
	        :basic_auth => { :username => "#{ENV['BILLPLZ_APIKEY_OLD']}" },
	        :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
	#render json: data_billplz and return
	data = JSON.parse(data_billplz.to_s)
	puts data
	if data["id"].present? && (data["paid"] == true)
		payment.paid = data["paid"]
		payment.mtd = "BILLPLZ"
		payment.updated_at = data["paid_at"]
		payment.save
	end
	sleep 1
end


end #task