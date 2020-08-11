
arr=[]
Payment.where(name: "KID BILL", paid: false).each do |payment|

url_bill = "#{ENV['BILLPLZ_API']}bills/#{payment.bill_id}"
data_billplz = HTTParty.get(url_bill.to_str,:body  => { }.to_json,:basic_auth => { :username => "#{ENV['BILLPLZ_APIKEY']}" },:headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
data = JSON.parse(data_billplz.to_s)
if data["id"].present? && (data["paid"] == true)
payment.paid = data["paid"]
payment.mtd = "BILLPLZ"
payment.updated_at = data["paid_at"]
arr << payment.id
payment.bill_id2 = data["id"]
payment.save
end
sleep 0.5
end
