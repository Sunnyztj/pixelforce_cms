class Notification < ActionMailer::Base
  default from: "<%= application_name %> Notification <noreply.<%= application_name.underscore %>@gmail.com>"

  def notify_us(contact)
    @contact = contact
    mail(
      to: 'bzbnhang@gmail.com',
      reply_to: "#{contact.full_name} <#{contact.email}>",
      subject: "[Contact Form] #{contact.full_name}"
    )
  end

end
