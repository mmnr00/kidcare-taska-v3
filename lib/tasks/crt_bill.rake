desc "Create Monthly Bill"
task crt_bill: :environment do

	dy = Time.now.day
	bl_dt = Time.now + 1.months
	mth = bl_dt.month
	yr = bl_dt.year 

	Taska.where(bldt: dy).each do |tsk|

		#init create Bill
		kids = tsk.kids.where.not(classroom_id: nil)

		#check if bill already exist
		kids.each do |kd|
			if kd.payments.where(bill_month: mth,bill_year: yr).blank?

				#init payment details
				amount = 0.00
				amount = amount + kd.classroom.base_fee
				kd.extras.each do |ext|
					amount += ext.price
				end 
				kd.beradik.each do |sb|
					amount = amount + sb.classroom.base_fee
					sb.extras.each do |ext|
						amount += ext.price
					end 
				end

				unq = (0...8).map { ('A'..'Z').to_a[rand(26)] }.join
	      while Payment.where(bill_id: unq).present?
	        unq = (0...8).map { ('A'..'Z').to_a[rand(26)] }.join
	      end

				#create payment 
				pmt = Payment.new(amount: amount,
													description: "",
													bill_month: mth,
													bill_year: yr,
													discount: 0,
													discdx: "",
													parent_id: kd.parent.id,
													taska_id: tsk.id,
													state: "due",
													paid: false,
													fin: false,
													bill_id: unq,
													reminder: false,
													name: "KID BILL",
													cltid: tsk.collection_id)
				pmt.save

				#create addition
				Addtn.create(desc: "",
												amount: 0,
												payment_id: pmt.id)

				#create kidbill
				kid_id = [kd.id]
				kd.beradik.each do |sb|
					kid_id << sb.id
				end
				Kid.where(id: kid_id).each do |kd|
					kb = KidBill.new(kid_id: kd.id,
													payment_id: pmt.id,
													kidname: kd.name,
													kidic: "#{kd.ic_1}-#{kd.ic_2}-#{kd.ic_3}",
													classroom_id: kd.classroom.id,
													clsname: kd.classroom.classroom_name,
													clsfee: kd.classroom.base_fee)
					cnt = 1
					kd.extras.each do |ext|
						kb.extra << ext.id
						extra = Extra.find(ext.id)
		        kb.extradtl["#{cnt}. #{extra.name}"] = extra.price
		        cnt = cnt + 1
					end
					kb.save
				end


			end			
		end #kid

		#send sms to admin
		puts "#{$month_name[mth]}-#{yr} bills created for #{kids.count} kid(s)"

	end #taska

end #task
