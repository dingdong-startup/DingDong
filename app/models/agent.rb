class Agent < ApplicationRecord
  belongs_to :position
  belongs_to :agency
  has_many :properties
end
