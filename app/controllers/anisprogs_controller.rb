class AnisprogsController < ApplicationController

	def anisprog_new
		params.require(:anisprog).permit(:name, :lec, :course_id, :id, :start, :end, :profurl)
		@progs = Anisprog.new
		@progs.name = params[:anisprog][:name] 
		@progs.lec = params[:anisprog][:lec]
		@progs.course_id = params[:anisprog][:course_id] 
		@progs.start = params[:anisprog][:start]
		@progs.end = params[:anisprog][:end] 
		@progs.profurl = params[:anisprog][:profurl] 
		if @progs.save
			
			flash[:success] = "Done"
			redirect_to owner_course_path(course: @progs.course_id, id: current_owner.id)
		end

	end

	def anisprog_edit
		@owner = current_owner
		@progs = Anisprog.find(params[:prog])
		render action: "anisprog_edit", layout: "dsb-owner-college"
	end

	def anisprog_update
		params.require(:anisprog).permit(:name, :lec, :course_id, :id, :start, :end, :profurl)
		@progs = Anisprog.find(params[:anisprog][:id])
		@progs.name = params[:anisprog][:name] 
		@progs.lec = params[:anisprog][:lec]
		@progs.course_id = params[:anisprog][:course_id]  
		@progs.start = params[:anisprog][:start]
		@progs.end = params[:anisprog][:end]
		@progs.profurl = params[:anisprog][:profurl]
		if @progs.save
			
			flash[:success] = "Done"
			redirect_to owner_course_path(course: @progs.course_id, id: current_owner.id)
		end
	end

	def anisprog_remove
	end

	
end