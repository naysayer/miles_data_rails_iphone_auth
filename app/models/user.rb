class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # before_create :ensure_authentication_token

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :token_authenticatable, :timeoutable
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :records

  
end
