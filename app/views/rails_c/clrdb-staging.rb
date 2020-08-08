Anisatt.all.each do |t|
t.destroy
end

Anisfeed.all.each do |t|
t.destroy
end

Tchdetail.where(anis: "true").each do |t|
t.destroy
end

Payment.where(name: "KID BILL").where.not(taska_id: 286).each do |t|
t.destroy
end

Anisprog.all.each do |t|
t.destroy
end

Foto.all.each do |t|
t.destroy
end

Feedback.all.each do |t|
t.destroy
end

KidExtra.all.each do |t|
t.destroy
end

Payinfo.all.each do |t|
t.destroy
end

Payslip.all.each do |t|
t.destroy
end

PtnsMmb.all.each do |t|
t.destroy
end

TeachersClassroom.all.each do |t|
t.destroy
end

TeacherCourse.all.each do |t|
t.destroy
end

TeacherCollege.all.each do |t|
t.destroy
end

Ptnssp.all.each do |t|
t.destroy
end

Parpaym.all.each do |t|
t.destroy
end

Otkid.all.each do |t|
t.destroy
end

Applv.all.each do |t|
t.destroy
end

Expense.all.each do |t|
t.destroy
end

Kidtsk.all.each do |t|
t.destroy
end

Sibling.all.each do |t|
t.destroy
end

TchdetailCollege.all.each do |t|
t.destroy
end



