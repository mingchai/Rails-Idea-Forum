class User < ApplicationRecord
  has_many :ideas
  has_secure_password
end
