class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :visible_to, -> (user) { user ? all : joins(:wiki).where('wikis.private' => false)}

  validates :title, length: { minimum: 5, maximum: 100 }, presence: true
  validates :body, length: { minimum: 20, maximum: 250 }, presence: true
  validates :user, presence: true
end
