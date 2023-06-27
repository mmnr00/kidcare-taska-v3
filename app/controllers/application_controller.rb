class ApplicationController < ActionController::Base
	 before_action :configure_permitted_parameters, if: :devise_controller?
	 protect_from_forgery prepend: true
	 require 'roo'

	 #def current_taska
	 	#return unless session[:Taska_id]
	 	#@current_taska ||= Taska.find(session[:Taska_id])
	 #end

	 def check_collection(id)
	 	url_bill = "#{ENV['BILLPLZ_API']}collections/#{id}"
      data_billplz = HTTParty.get(url_bill.to_str,
              :body  => { }.to_json, 
                          #:callback_url=>  "YOUR RETURN URL"}.to_json,
              :basic_auth => { :username => "#{ENV['BILLPLZ_APIKEY']}" },
              :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
      #render json: data_billplz and return
      data = JSON.parse(data_billplz.to_s)
      if data["id"].present?
      	return data
      else
      	return false
      end
	 end

	 def check2_bill(pmt)
	 	payment = Payment.find(pmt) 
		#check payment status
		if !payment.paid #&& Rails.env.production?
			url_bill = "#{ENV['BILLPLZ_API']}bills/#{payment.bill_id2}"
      data_billplz = HTTParty.get(url_bill.to_str,
              :body  => { }.to_json, 
                          #:callback_url=>  "YOUR RETURN URL"}.to_json,
              :basic_auth => { :username => "#{ENV['BILLPLZ_APIKEY']}" },
              :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
      #render json: data_billplz and return
      data = JSON.parse(data_billplz.to_s)
      if data["id"].present? && (data["paid"] == true)
      	payment.paid = data["paid"]
      	payment.mtd = "BILLPLZ"
      	payment.updated_at = data["paid_at"]
      	payment.save
      end
		end
	 end

	 

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
