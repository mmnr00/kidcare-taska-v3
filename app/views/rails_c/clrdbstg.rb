Anisfeed.all.delete_all
Anisatt.all.delete_all

Payment.where.not(taska_id: 52).each do |pmt|
pmt.destroy
end

Tchdetail.where(anis: "true").each do |tch|
tch.fotos.delete_all
tch.destroy
end

Feedback.all.delete_all

PtnsMmb.all.each do |pt|
pt.fotos.each do |ft|
ft.destroy
end
pt.destroy
end

Ptnssp.all.delete_all

Foto.where(taska_id: nil).delete_all

TchdetailCollege.delete_all

Tchlv.delete_all

Anisprog.delete_all

Applv.delete_all

Taska.where(plan: ["mbr19","mbr20"]).count

Taska.where("plan like?", "%MBR%" )

Taska.where(expire: nil).each do |tsk|
tsk.fotos.each do |ft|
ft.destroy
end
tsk.destroy
end

Taska.all.each do |tsk|
if (tsk.expire.to_date - Date.today).to_int < -10
tsk.fotos.each do |ft|
ft.destroy
end
tsk.destroy
end
end















