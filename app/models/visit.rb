class Visit < ApplicationRecord
  belongs_to :tenant
  belongs_to :property
  belongs_to :visit_status 
end
