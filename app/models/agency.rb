class Agency < ApplicationRecord
  after_create :welcome_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :agency_groups
  has_many :groups, through: :agency_groups

  has_many :agents
  has_many :properties

  validates :name, :phone, :address, :email, presence: true

  def welcome_send
    AgencyMailer.welcome_email(self).deliver_now
  end
  

end
