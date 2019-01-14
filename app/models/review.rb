class Review < ApplicationRecord
  belongs_to :user
  belongs_to :idea

  validates :title, presence: true
end
