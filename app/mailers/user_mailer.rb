class UserMailer < ApplicationMailer

	def send_inquiry_email obj
		@inquiry = obj
		@email = obj.email
		mail(to: @email, subject: "Subject here...!!")
	end
end
