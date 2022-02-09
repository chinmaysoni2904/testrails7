class InquiriesController < ApplicationController

	def index
		@inquiries = CompanyInquiry.order("created_at desc")
	end

	def new

	end

	def create
		@inquiry = CompanyInquiry.new(inquiry_params)
		if @inquiry.save
			redirect_to inquiries_path, notice: "Your details are submitted"
		else
			render :new, status: :unprocessable_entity
		end
	end

	private

	def inquiry_params
		params.require(:company_inquiry).permit(:company_name, :first_name, :last_name, :email, :phone_number, :no_of_employee, :company_type)
	end
end
