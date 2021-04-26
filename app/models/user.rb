class User < ApplicationRecord
    has_many :products

    VALID_PHONE_REGEX = /\A[+-]?\d+?(\.\d+)?\Z/
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
    validates :phone, presence: true, length: { maximum: 11 }, format: { with: VALID_PHONE_REGEX }, uniqueness: true
    validates :password, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
end
