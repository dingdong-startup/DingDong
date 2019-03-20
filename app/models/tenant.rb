class Tenant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :visits
  belongs_to :payment_status

  before_validation :default_payment_status

  has_many :favorites
  has_many :properties, through: :favorites

  has_one_attached :avatar


  before_create :attach_avatar

  def default_payment_status
    self.payment_status_id ||= 1
  end

  def fav_properties
    self.visits.where(visit_status_id: 2)
  end

  def asked_visits
    self.visits.where(visit_status_id: 3)
  end

  def successful_rent
    self.visits.where(visit_status_id: 6)
  end

  def attach_avatar
    self.avatar.attach(io: File.open('app/assets/images/avatar.jpg'), filename: 'avatar.jpg', content_type: 'image/jpg')
  end


end
