# Preview all emails at http://localhost:5000/rails/mailers/example_mailer
class ExampleMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    ExampleMailer.sample_email(User.first)
  end
end
