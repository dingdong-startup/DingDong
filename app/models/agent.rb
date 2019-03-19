class Agent < ApplicationRecord
  belongs_to :position
  belongs_to :agency
  has_many :properties

  validates :first_name, :last_name, :cellphone, :email, presence: true
end
