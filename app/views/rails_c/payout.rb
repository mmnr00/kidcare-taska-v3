payment = Payment.find(16109)
url_bill = "https://www.billplz.com/api/v4/mass_payment_instructions"
data_billplz = HTTParty.post(url_bill.to_str,
:body  => { 
:mass_payment_instruction_collection_id => "tcep0zs2",
:bank_code => "BIMBMYKL",
:bank_account_number => "12038010088442",
:identity_number => "SA0099862H",
:name => "TASKA SARJANA PINTAR",
:description => "Try KidCare 2",
:total => 0.1*100
}.to_json,
:basic_auth => { :username => "#{ENV['BILLPLZ_APIKEY']}" },
:headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })

data = JSON.parse(data_billplz.to_s)
