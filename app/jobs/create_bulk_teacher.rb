(1..35).each do |k|
bs = "demo_admin#{k}"
puts bs
Admin.create(username: bs, email: "#{bs}@kidcaredemo.my", password: "demokidcare@123", tnc: "true")
end

(1..35).each do |k|
bs = "demo_parent#{k}"
puts bs
Parent.create(username: bs, email: "#{bs}@kidcaredemo.my", password: "demokidcare@123", tnc: "true")
end

(1..35).each do |k|
bs = "demo_staff#{k}"

tch = Teacher.new(username: bs, email: "#{bs}@kidcaredemo.my", password: "demokidcare@123", tnc: "true")
tch.save
tchdt = Tchdetail.new(name: bs,teacher_id: tch.id)
tchdt.save
Foto.create(foto_name: "SIJIL KAP", tchdetail_id: tchdt.id)
Foto.create(foto_name: "KURSUS PENGEDALIAN MAKANAN", tchdetail_id: tchdt.id)
Foto.create(foto_name: "TYPHOID INJECTION", tchdetail_id: tchdt.id)
Foto.create(foto_name: "CPR / FIRST AID", tchdetail_id: tchdt.id)
Foto.create(foto_name: "IC FRONT", tchdetail_id: tchdt.id)
Foto.create(foto_name: "IC BACK", tchdetail_id: tchdt.id)
Foto.create(foto_name: "PROFILE PIC", tchdetail_id: tchdt.id)

end






