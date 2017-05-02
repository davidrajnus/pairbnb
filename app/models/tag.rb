class Tag < ApplicationRecord
  belongs_to :listing

   enum property_type: [:house, :apartment]
   enum room_type: [:shared, :entire]
   enum wifi: [:yes, :no]
   enum kitchen: [:full, :small, :common]


end
