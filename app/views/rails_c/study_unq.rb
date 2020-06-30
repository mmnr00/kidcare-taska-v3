
an = 8
fnd = false
arr=[]

while !fnd && an < 15

unq = (0...an).map { ('A'..'Z').to_a[rand(26)] }.join
arr<< unq
cnt = 0

while Classroom.where(classroom_name: unq).blank? && cnt < 11
unq = (0...an).map { ('A'..'Z').to_a[rand(26)] }.join
arr << unq
#fnd = true unless Classroom.where(classroom_name: unq).present? 
cnt += 1
end

an += 1

end 
