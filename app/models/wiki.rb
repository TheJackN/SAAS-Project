class Wiki < ActiveRecord::Base
  # belongs_to :user

  has_many :collaborations
  has_many :users, through: :collaborations

  scope :visible_to, -> (user) { user ? all : joins(:wiki).where('wikis.private' => false)}

  validates :title, length: { minimum: 5, maximum: 100 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user_id, presence: true

  def user
    User.find(user_id)
  end
end
