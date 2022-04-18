class Cycle < ApplicationRecord
  has_many :invitations

  validates_presence_of :name
end
