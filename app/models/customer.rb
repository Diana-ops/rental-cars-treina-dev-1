class Customer < ApplicationRecord

	has_many :car_rentals
	has_many :rentals, through: :car_rentals

	validates :document, :email, uniqueness: true
	validates :name, :document, :email, presence: true
	scope :search, ->(query) { where('name LIKE ?', "%#{query}%")
                              .or(where(document: query)) }
end
