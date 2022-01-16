@kbl = Payment.where.not(bill_id2: nil).where(name: "KID BILL",paid: false)
@kbl.each do |payment|
if !payment.paid #&& Rails.env.production?
url_bill = "#{ENV['BILLPLZ_API']}bills/#{payment.bill_id2}"
data_billplz = HTTParty.get(url_bill.to_str,
:body  => { }.to_json, 
      #:callback_url=>  "YOUR RETURN URL"}.to_json,
:basic_auth => { :username => "#{ENV['BILLPLZ_APIKEY']}" },
:headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
#render json: data_billplz and return
data = JSON.parse(data_billplz.to_s)
if data["id"].present? && (data["paid"] == true)
payment.paid = data["paid"]
payment.mtd = "BILLPLZ"
payment.updated_at = data["paid_at"]
payment.save
end
end
sleep 0.5
end

@kbl2 = Payment.where.not(bill_id2: nil).where(name: "KID BILL",paid: false)
@kbl2.each do |bl2|
bl2.bill_id2 = nil 
bl2.save
end