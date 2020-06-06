a=[331,335,332]
Anisprog.where(id: a).each do |pr|
pr.destroy
end
