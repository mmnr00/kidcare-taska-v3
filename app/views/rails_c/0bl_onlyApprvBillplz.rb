t=Taska.find(593)
pmts = t.payments.where(name: "KID BILL")
pmts.count

pmts.each do |pm|

kid = pm.kids.first

url_bill = "#{ENV['BILLPLZ_API']}bills"
data_billplz = HTTParty.post(url_bill.to_str,
            :body  => { :collection_id => t.collection_id, 
                        :email=> "bill@kidcare.my",
                        :name=> "#{kid.name}", 
                        :amount=>  (pm.amount.to_f)*100,
                        :callback_url=> "#{ENV['ROOT_URL_BILLPLZ']}payments/update",
                        :redirect_url=> "#{ENV['ROOT_URL_BILLPLZ']}payments/update",
                        :description=> pm.description}.to_json, 
                        #:callback_url=>  "YOUR RETURN URL"}.to_json,
            :basic_auth => { :username => ENV['BILLPLZ_APIKEY'] },
            :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
    #render json: data_billplz and return
    data = JSON.parse(data_billplz.to_s)

pm.bill_id = data["id"]
pm.cltid = t.collection_id
pm.save

end
