class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :polls, dependent: :destroy
  has_many :polls_through_history, through: :history, class_name: "Poll", foreign_key: "poll_id", source: :poll

  validates :auth_token, uniqueness: true
  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin 
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
