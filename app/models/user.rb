class User < ApplicationRecord
    has_secure_password

    has_many :questions, dependent: :destroy
    has_many :comments, dependent: :destroy

    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :name, presence: true
    validates :password, presence: true

end
