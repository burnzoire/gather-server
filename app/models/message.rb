class Message < ApplicationRecord
  validates :content, presence: true
  belongs_to :postable, polymorphic: true
  belongs_to :user
end
