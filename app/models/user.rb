class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  before_create :ensure_authentication_token

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :token_authenticatable, :timeoutable
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :records

  before_create :set_default_token_time

  def token_expired?
    self.token_generated_at.blank? || self.authentication_token.blank? || self.token_generated_at < 1.week.ago
  end

  def self.generate_new_auth_token(resource)
  	resource.reset_authentication_token!
  	resource.token_generated_at = Time.now
  	resource.save
  end

  def set_default_token_time
    self.token_generated_at = Time.now
  end
  
end
