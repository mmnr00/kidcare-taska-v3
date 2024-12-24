desc "try delay"
task trydelay: :environment do
	(1..20).each do |num|
		puts num 
		sleep 60
	end
end