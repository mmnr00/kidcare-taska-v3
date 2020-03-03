curr_crs = 3
curr_clg = 4
n = 1..10

College.find(curr_clg).tchdetails.each do |tcd|

if tcd.anisfeeds.where(course_id: curr_crs).blank?

old_anf = Anisfeed.find(rand(n))
new_anf = old_anf.dup
new_anf.tchdetail_id = tcd.id
new_anf.save

old_anf.feedbacks.each do |fb|
fbn = fb.dup
fbn.anisfeed_id = new_anf.id
fbn.save
end

end

end
