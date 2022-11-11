class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    validates :title, presence: true, uniqueness: {scope: :title}
    validates :body, presence: true
end
