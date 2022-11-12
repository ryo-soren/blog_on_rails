class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user
    validates :title, presence: true, uniqueness: {scope: :title}
    validates :body, presence: true
end
