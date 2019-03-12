class Position < ApplicationRecord
  has_many :agents

  validates :title, 
    presence: true,
    uniqueness: true
end
