class Position < ApplicationRecord
  has_many :agencies

  validates :title, 
    presence: true,
    uniqueness: true
end
