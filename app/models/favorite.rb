class Favorite < ApplicationRecord
  belongs_to :user
  
  validates_uniqueness_of :address, scope: :user_id

  validates_presence_of :category,
                        :name,
                        :description,
                        :address,
                        :website,
                        :phone,
                        :fees,
                        :schedule
end