id = 10156 #11-06
Payment.where(name: "KID BILL").each do |pm|
upd = pm.updated_at

pm.discount = 0.00 unless pm.discount.present?
pm.fin = true

pm.save
pm.updated_at = upd
pm.save
end

p = Payment.find(id)

Payment.where(name: "KID BILL",discount: nil).last
