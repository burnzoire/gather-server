class Topic < ApplicationRecord
  validates :title, presence: true
  belongs_to :forum
  belongs_to :user
end
