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

  def default_payment_status
    self.payment_status_id ||= 1
  end
end
