class ExampleMailer < ApplicationMailer
  default from: "info@campaignmanager.xyz"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
