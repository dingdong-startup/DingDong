class Visit < ApplicationRecord
  belongs_to :status
  belongs_to :tenant
  belongs_to :property
end
