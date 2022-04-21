class Invitation < ApplicationRecord
  EMAIL_WITH_NAME_PATTERN = /(?<name>[a-zA-Z\s]+)<(?<email>[^@\s]+@[-a-z0-9]+\.+[a-z]{2,})>/i
  ONLY_EMAIL_PATTERN = /(?<username>[^@\s]+)@[-a-z0-9]+\.+[a-z]{2,}/i
  VALIDATION_PATTERN = Regexp.union(EMAIL_WITH_NAME_PATTERN, ONLY_EMAIL_PATTERN)

  belongs_to :cycle

  validates_presence_of :email
  validates_format_of :email, with: VALIDATION_PATTERN

  before_create :extract_name_and_email

  def extract_name_and_email
    match_data = email.match(VALIDATION_PATTERN)
    return self.name = generate_name_from(match_data[:username]) if match_data[:name].nil?

    self.name = match_data[:name].strip
    self.email = match_data[:email]
  end

  private

  def generate_name_from(username)
    username.split('.').map(&:capitalize).join(' ').tr('0-9', '').strip
  end
end
