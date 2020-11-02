all_anisf = [8,46,50,51,54,55,57,60,63,69,71,82,84,65,67,76,77,78,80,86]

arr = []

all_anisf.each do |idc|

clg = College.find(idc)

clg.tchdetails.ids.each do |idt|
arr << idt #unless arr.include? idt
end

end
