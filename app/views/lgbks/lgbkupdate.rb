
hari_arr = [7,8,9,10,17]

hari_arr.each do |dy|
	day = dy
	cin = Time.new(2025,7,day,7,30,0)
	cout = Time.new(2025,7,day,18,30,0)

	sod = Date.new(2025,7,day).beginning_of_day
	eod = Date.new(2025,7,day).end_of_day

	Taska.find(705).kids.each do |kd|
		kd.lgbks.where(created_at: sod..eod).each do |lg|
			lg.cin = [cin, lg.cin[1], lg.cin[2]]
			lg.cout = [cout, lg.cout[1], lg.cout[2]]
			lg.save
		end
	end
end
