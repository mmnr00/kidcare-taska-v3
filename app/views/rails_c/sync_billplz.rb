#STEP 1 - update all bills first
pmts = Payment.where(name: "KID BILL", paid: false)
pmts.count

pmts.each do |payment|

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

end

#############################
#STEP 2 - eliminate all bill_id already paid in kidcare
pmtsd = Payment.where(name: "KID BILL", paid: false)
pmtsp = Payment.where(name: "KID BILL", paid: true)

arr = []
pmtsp.each do |pm|

kidname = ""
pm.kid_bills.each do |kb|
if kidname.blank?
kidname = kb.kidname
else
kidname = kidname + ", " + kb.kidname
end #if kidname
end #kid_bill

if bill_id[pm.bill_id2].present? ; if 1==1#bill_id[pm.bill_id2] == kidname
arr<<pm.bill_id2
end; end #check hash

end #payments paid

arr.each do |num|
bill_id.delete(num)
end

################################################
#STEP 3 - find missing bill_id2 in KidCare
pmtsd = Payment.where(name: "KID BILL", paid: false)
hsh = {}
arr = []

pmtsd.each do |pm|

kidname = ""
pm.kid_bills.each do |kb|
if kidname.blank?
kidname = kb.kidname
else
kidname = kidname + ", " + kb.kidname
end #if kidname
end #kid_bill

if bill_id.key([kidname,pm.amount.round(2)]).present?
  if 1==1
    hsh[pm.id] = kidname
    arr<<kidname
  end
end

end #all payment


####### Other codes
a={
12074=>"mtoxamws",
12437=>"ee0byagt",
12625=>"i1vl278y",
12925=>"03pu2n8j",
12909=>"apkwfbwr",
12984=>"b4s0ic1e",
13546=>"i1vl278y",
}

a.each do |k,v|
pm=Payment.find(k)
pm.bill_id2 = v
pm.save
end



























