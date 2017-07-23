class Organisation < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :forums
end
