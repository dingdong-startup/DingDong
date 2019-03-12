class AgencyGroup < ApplicationRecord
  belongs_to :group
  belongs_to :agency
end
