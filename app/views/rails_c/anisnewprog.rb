old = 81
nw = 82

clg=College.find(old)
clgn = College.find(nw)

clg.courses.each do |crs|
a = crs.dup
a.college_id = nw

if a.name == "DAY 1"
a.start = clgn.start
elsif a.name == "DAY 2"
a.start = clgn.start + 1.days
elsif a.name == "DAY 3"
a.start = clgn.end
end

a.save

crs.anisprogs.each do |ap|
b = ap.dup
b.course_id = a.id 
b.lec = ap.lec
b.save
end

end

# NEW ANIS MCO

old = 88
nw = 91

clg=College.find(old)
clgn = College.find(nw)

dt = clgn.start - 1.days

clg.courses.order('start ASC').each do |crs|
a = crs.dup
a.college_id = nw
a.start = dt
a.save

crs.anisprogs.each do |ap|
b = ap.dup
b.course_id = a.id
b.save

end #end anisprogs

dt = dt + 1.days

end #end course

 