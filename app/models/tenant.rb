class Tenant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
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
    self.favorites.where(is_liked: true)
  end

  def asked_visits
    self.visits.where(visit_status_id: 4)
  end

  def successful_rent
    self.visits.where(visit_status_id: 6)
  end

  def attach_avatar
    self.avatar.attach(io: File.open('app/assets/images/avatar.png'), filename: 'avatar.png', content_type: 'image/png')
  end


  def existant_visit(property)
    visit = Visit.find_by(property_id: property.id, tenant: self)
    if visit
      return visit
    end
  end

  def unfav(property)
    favoris = Favorite.find_by(property_id: property.id, tenant: self, is_liked: true)
    unless favoris.nil?
      favoris.update_attributes(is_liked: false)
    end
  end


  def welcome_mail
    TenantMailer.welcome_email(self).deliver_now
  end

  def requested_visits
    self.visits.where(visit_status_id: 4)
  end

  def fav_properties
    self.favorites.where(is_liked: true)
  end

  def property_fav(property)
    self.favorites.where(property: property)
  end


end
