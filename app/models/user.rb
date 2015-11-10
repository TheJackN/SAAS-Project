class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :wikis
  has_many :collaborations
  has_many :wikis, through: :collaborations

  validates :name, length: { minimum: 5, maximum: 100 }, presence: true

  before_save { self.role ||= :standard }

  enum role: [:standard, :premium, :admin]

  def self.avatar_url(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  
  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end
end
