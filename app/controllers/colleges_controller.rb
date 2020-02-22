class CollegesController < ApplicationController
	before_action :set_owner
	before_action :set_college, only: [:edit, :update, :destroy, :anis_reglist, :college_report, :college_reportxls]

	def index
	end

	def crtatt
		@college = College.find(params[:id])
		prc = true
		prc = false unless Anisatt.where(course_id: @college.courses.ids).blank?
		if prc
			tchds = @college.tchdetails
			@college.courses.each do |crs|
				crs.anisprogs.where.not(name: "BREAK").each do |an|
					tchds.each do |tch|
						Anisatt.create(course_id: crs.id, tchdetail_id: tch.id, anisprog_id: an.id, att: true)
					end
				end
			end
			flash[:success] = "Kehadiran dikemaskini untuk semua peserta"
		else
			flash[:danger] = "Kehadiran untuk program sudah diwujudkan"
		end
		
		redirect_to show_owner_path(id: current_owner.id, college: @college.id)
	end

	def infopage
		@college = College.find(params[:college_id])
	end

	def new
		@college = College.new
		render action: "new", layout: "dsb-owner-college"
	end

	def create
		@college = College.new(college_params)
		if @college.save	
			@owner_college = OwnerCollege.create(owner_id:@owner.id, college_id:@college.id)
			@owner_college2 = OwnerCollege.create(owner_id:Owner.first.id, college_id:@college.id)			
			flash[:notice] = "College was successfully created"					
			redirect_to owner_index_path;		
			#redirect_to create_collection_college_path(@owner, college_id:@college.id) 							
		else
			render :new
		end
	end

	def show_owner
		@college = College.find(params[:college])
		@tchdetails = @college.tchdetails.order('name ASC')
		#@tch = Tchdetail.new
		render action: "show_owner", layout: "dsb-owner-college"
	end

	# FOR ANIS 
	def assg_clg_tch
		tchdetail = Tchdetail.find(params[:tchd_id])
		# clgid= tchdetail.colleges.ids
		# if $anis2.include?(params[:clg].to_i) || ($anis2f.include?(params[:clg].to_i) && !(clgid&$anis2).any?)
		# 	tch_clg = TchdetailCollege.new(tchdetail_id: tchdetail.id)
		# else
		# 	tch_clg = tchdetail.tchdetail_colleges.last
		# end
		exstcl = tchdetail.tchdetail_colleges.where(tp: params[:tp])
		if exstcl.present?
			tch_clg = exstcl.last
		else
			tch_clg = TchdetailCollege.new(tchdetail_id: tchdetail.id, tp: params[:tp])
		end
		tch_clg.college_id = params[:clg]
		if t=tch_clg.save
			flash[:success] = "Registration Successful"
		else
			flash[:success] = "#{tch_clg.errors.full_messages}"
		end
		redirect_to tchd_anis_path(id: tchdetail.id, anis: true)
	end

	def assg_clg_tch_old
		tchdetail = Tchdetail.find(params[:tchd_id])
		clgid= tchdetail.colleges.ids
		if $anis2.include?(params[:clg].to_i) || ($anis2f.include?(params[:clg].to_i) && !(clgid&$anis2).any?)
			tch_clg = TchdetailCollege.new(tchdetail_id: tchdetail.id)
		else
			tch_clg = tchdetail.tchdetail_colleges.last
		end
		tch_clg.college_id = params[:clg]
		if t=tch_clg.save
			flash[:success] = "Registration Successful"
		else
			flash[:success] = "#{tch_clg.errors.full_messages}"
		end
		redirect_to tchd_anis_path(id: tchdetail.id, anis: true)
	end

	def assg_clg
		curr_clg = params[:ans][:curr_clg]
		params[:ans].each do |k,v|
			if k != "curr_clg"
				tchdetail = Tchdetail.find(k)
				if v[:college_ids] != ""
					tch_clg = tchdetail.tchdetail_colleges.where(tp: v[:tp]).first
					tch_clg.college_id = v[:college_ids]
					tch_clg.save
				end
				tchdetail.dun = v[:dun]
				tchdetail.ands = v[:ands]
				tchdetail.stat = v[:stat]
				tchdetail.picst = v[:picst]
				tchdetail.save
			end
		end

		flash[:success] = "Update Successful"
		redirect_to show_owner_path(id: @owner.id, college: curr_clg)
	end

	def assg_clg_old
		tchdetail = Tchdetail.find(params[:tchdetail][:tchd_id])
		tch_clg = tchdetail.tchdetail_colleges.where(tp: params[:tchdetail][:tp]).first
		tch_clg.college_id = params[:tchdetail][:college_ids]
		if tch_clg.save
			flash[:success] = "#{tchdetail.name} successfully assigned to #{tch_clg.college.name}"
		else
			flash[:danger] = "Assign not successfull. Please try again"
		end
		redirect_to show_owner_path(id: @owner.id, college: params[:tchdetail][:curr_clg])
	end

	def anis_reglist
		@tchdetails = @college.tchdetails.order('name ASC')
	end

	def college_report
		@tchds = @college.tchdetails
		@age = Hash.new
		@age["<20"] = 0
		@age["20-30"] = 0
		@age["30-40"] = 0
		@age["40-50"] = 0
		@age[">50"] = 0
		@tchds.each do |tch|
			age = Date.today.year - tch.dob.year
			if age < 20
				@age["<20"] = @age["<20"] + 1
			elsif age < 30
				@age["20-30"] = @age["20-30"] + 1
			elsif age < 40
				@age["30-40"] = @age["30-40"] + 1
			elsif age < 50
				@age["40-50"] = @age["40-50"] + 1
			elsif age > 50
				@age[">50"] = @age[">50"] + 1
			end	
		end
		@courses = @college.courses.order('start ASC')
		render action: "college_report", layout: "dsb-owner-college"
	end

	def college_reportxls
		@tchds = @college.tchdetails
		@courses = @college.courses.order('start ASC')
		@totalprog = 0
		@courses.each do |crs|
			@totalprog = @totalprog + crs.anisprogs.where.not(name: "BREAK").count
		end
		@age = Hash.new
		@age["<20"] = 0
		@age["20-30"] = 0
		@age["30-40"] = 0
		@age["40-50"] = 0
		@age[">50"] = 0
		@tchds.each do |tch|
			age = Date.today.year - tch.dob.year
			if age < 20
				@age["<20"] = @age["<20"] + 1
			elsif age < 30
				@age["20-30"] = @age["20-30"] + 1
			elsif age < 40
				@age["30-40"] = @age["30-40"] + 1
			elsif age < 50
				@age["40-50"] = @age["40-50"] + 1
			elsif age > 50
				@age[">50"] = @age[">50"] + 1
			end	
		end
		respond_to do |format|
      #format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; filename="Report.xlsx"'
      }
    end
	end

	def chsreport
		@colleges = College.where(id: $anisf | $anis2f)
		@mus = Taska.all
		render action: "chsreport", layout: "dsb-owner-college"
	end

	

	def overall_reportxls
		clg_ids = []
		params[:ans].each do |k,v|
			if v[:picst] == "1"
				clg_ids << k
			end
		end

		if clg_ids.blank?
			flash[:danger] = "Please Choose A Session"
			redirect_to chsreport_path
		else
			@college = College.find(clg_ids)
			#@collegen = College.order('start ASC')
			@tchds = nil
			@courses = nil
			@college.each do |clg|
				if @tchds.blank?
					@tchds = clg.tchdetails
				else
					@tchds = @tchds.or(clg.tchdetails)
				end
				if @courses.blank?
					@courses = clg.courses.order('start ASC')
				else
					@courses = @courses.or(clg.courses.order('start ASC'))
				end
			end
			@totalprog = 0
			@courses.each do |crs|
				@totalprog = @totalprog + crs.anisprogs.where.not(name: "BREAK").count
			end
			@age = Hash.new
			@age["<20"] = 0
			@age["20-30"] = 0
			@age["30-40"] = 0
			@age["40-50"] = 0
			@age[">50"] = 0
			@tchds.each do |tch|
				age = Date.today.year - tch.dob.year
				if age < 20
					@age["<20"] = @age["<20"] + 1
				elsif age < 30
					@age["20-30"] = @age["20-30"] + 1
				elsif age < 40
					@age["30-40"] = @age["30-40"] + 1
				elsif age < 50
					@age["40-50"] = @age["40-50"] + 1
				elsif age > 50
					@age[">50"] = @age[">50"] + 1
				end	
			end
			respond_to do |format|
	      #format.html
	      format.xlsx{
	        response.headers['Content-Disposition'] = 'attachment; filename="Report.xlsx"'
	      }
	    end
	    #flash[:success] = "Reports Generated Successfully"
	    #redirect_to chsreport_path
	  end
	end

	# END ANIS

	def show_teacher
		@teacher = Teacher.find(params[:id])
		@college = College.find(params[:college])
		@teacher_payments = @teacher.payments
		render action: "show_teacher", layout: "dsb-teacher-edu"
	end

	def edit
		render action: "edit", layout: "dsb-owner-college"
	end

	def update
		if @college.update(college_params)
			flash[:notice] = "#{@college.name} was successfully updated"
			redirect_to owner_index_path
		else
			render 'edit'
		end
	end

	def destroy
		owner_college = OwnerCollege.where(college_id: @college.id) 
		owner_college.delete_all
		@college.destroy
		flash[:notice] = "Expenses was successfully deleted"
		redirect_to owner_index_path;
	end




	private

	def set_owner
		@owner = current_owner
	end

	def set_college
		@college = College.find(params[:id])
	end

	def college_params
			params.require(:college).permit(:name, :address, :start, :end, :thm)
	end

end





