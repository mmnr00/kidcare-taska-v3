Kid.where(taska_id: $cakna21).each do |kd|

inc = kd.income

if inc == "Below RM3860" || inc == "" || inc == "RM3,860.00 and below"
kd.income = "RM2,500 - RM4,849"

elsif inc == "RM3860 - RM5000" 
kd.income = "RM2,500 - RM4,849"

elsif inc == "RM5000 - RM8000" || inc == "RM3,860.00 to RM8,319.00"
kd.income = "RM7,100 - RM10,959"

elsif inc == "Above RM8000" || inc == "RM8,319.00 and above"
kd.income = "RM7,100 - RM10,959"

end

kd.save

end

