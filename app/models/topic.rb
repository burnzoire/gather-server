class Topic < ApplicationRecord
  validates :title, presence: true
  belongs_to :forum
  belongs_to :user
  has_many :messages, as: :postable
end
