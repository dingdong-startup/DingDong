class Agency < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :agency_groups
  has_many :groups, through: :agency_groups
  
  has_many :agents
  has_many :properties
  
 
  validates :phone, numericality: { only_integer: true }
  validates :password, length: { minimum: 6 }
  validates :email, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/





  after_create :create_agents


  def create_agents

  	director = Agent.create(first_name: "",
  		last_name: "",
  		email: "",
  		cellphone: "",
  		position_id: 1,
  		agency_id: self.id)

  	agent = Agent.create(first_name: "",
  		last_name: "",
  		email: "",
  		cellphone: "",
  		position_id: 2,
  		agency_id: self.id)

  end


>>>>>>> dev
end
