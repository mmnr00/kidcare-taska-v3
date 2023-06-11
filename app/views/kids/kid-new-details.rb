Kid.all.each do |tch|
Foto.create(foto_name: "OKU FRONT", kid_id: tch.id)
Foto.create(foto_name: "OKU BACK", kid_id: tch.id)

end

rails g migration AddKcToKids okutype:string okuregno:string