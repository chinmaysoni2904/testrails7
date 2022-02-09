class CompanyInquiry < ApplicationRecord
	validates :company_name, :first_name, :last_name, :company_type, :email, :phone_number, :no_of_employee, presence: true
	validates_format_of :email, :with => /(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})/i
	validates_format_of :phone_number, with: /[6789][0-9]{9}/

	after_save :send_email, if: Proc.new{|o| o.new_record? }

	def send_email
		begin
			UserMailer.send_inquiry_email(self).deliver
		rescue Exception => e
			Rails.logger.info "Mail sending Error: #{e.message}"
		end
	end
end
