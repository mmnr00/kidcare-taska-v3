TchdetailCollege.where(college_id: [73,74,75],tp: "an1").each do |tcl|
tcl.tp = "an2"
tcl.save
end

a=[]
TchdetailCollege.where(college_id: [73,74,75]).each do |tcl|

if TchdetailCollege.where.not(id: tcl.id).where(tchdetail_id: tcl.tchdetail_id,college_id: tcl.college_id).present?

a<<[tcl.college_id,tcl.tchdetail_id]


end

end

c=[]
a.each do |b|

c << TchdetailCollege.where(college_id: b[0],tchdetail_id: b[1]).last.id

end

c.uniq.each do |d|
tc = TchdetailCollege.find(d)
tc.destroy
end

