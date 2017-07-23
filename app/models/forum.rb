class Forum < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  belongs_to :organisation
end
