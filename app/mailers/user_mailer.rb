class UserMailer < ApplicationMailer
	default from: "manfbenvenuti@gmail.com", from_name: "Entraded"

	# Subject can be set in your I18n file at config/locales/en.yml
	# with the following lookup:
	#
	#   en.user_mailer.welcome_mail.subject
	#
	def received_order(user, order)
	  @order = order
	  @user = user
	  mail(to: user.email, subject: "You received an offer")
	end

	def refused_order(user, order)
	  @order = order
	  @user = user
	  mail(to: user.email, subject: "You received an offer")
	end
end
