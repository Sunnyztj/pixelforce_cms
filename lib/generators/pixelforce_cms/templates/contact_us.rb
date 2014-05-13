class ContactUs
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  include ActiveModel::Validations

  attr_accessor :full_name, :contact_number, :email, :enquiry, :donate, :captcha

  validates :full_name, :contact_number, :email, :enquiry, presence: true

  def initialize(attributes = {})
    attributes.each do |attr, value|
      self.send "#{attr}=", value
    end unless attributes.blank?
  end

  def persisted?
    false
  end

  def save
    return if captcha.present?
    if valid?
      Notification.notify_us(self).deliver
    end
  end

end