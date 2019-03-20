class Agency < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :agency_groups
  has_many :groups, through: :agency_groups
  
  has_many :agents
  has_many :properties
  
 
  validates :email, presence: true

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

  def available_properties
    self.properties.where(is_archived: false)
  end 

end
