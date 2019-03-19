class Agency < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :agency_groups
  has_many :groups, through: :agency_groups
  
  has_many :agents
  has_many :properties

  validates :name, :phone, :address, :email, presence: true
  validates :phone, numericality: { only_integer: true }
  validates :password, length: { minimum: 6 }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
