class Invitation < ApplicationRecord
  EMAIL_WITH_NAME_PATTERN = /\A(?<name>[a-zA-Z\s]+)<(?<email>[^@\s]+@[^@\s]+)>\z/i
  EMAIL_PATTERN = /\A[^@\s]+@[-a-z0-9]+\.+[a-z]{2,}\z/i

  belongs_to :cycle

  validates_presence_of :email
  validates_format_of :email, with: EMAIL_PATTERN

  before_validation :extract_name_and_email, unless: proc { email.empty? }

  def extract_name_and_email
    match_data = email.match(EMAIL_WITH_NAME_PATTERN)
    return self.name = generate_name_from(email) if match_data.nil? && !email.empty?

    self.name = match_data[:name].strip
    self.email = match_data[:email]
  end

  private

  def generate_name_from(email_input)
    email_input.split('@').first.split('.').map(&:capitalize).join(' ').tr('0-9', '').strip
  end
end
