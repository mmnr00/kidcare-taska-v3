Tchdetail.where.not(teacher_id: nil).each do |tch|
Foto.create(foto_name: "SIJIL KAP", tchdetail_id: tch.id)
Foto.create(foto_name: "KURSUS PENGEDALIAN MAKANAN", tchdetail_id: tch.id)
Foto.create(foto_name: "TYPHOID INJECTION", tchdetail_id: tch.id)
Foto.create(foto_name: "CPR / FIRST AID", tchdetail_id: tch.id)


end

rails g migration AddKcToKids okutype:string okuregno:string