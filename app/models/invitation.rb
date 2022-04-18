class Invitation < ApplicationRecord
  belongs_to :cycle

  validates_presence_of :email
end
