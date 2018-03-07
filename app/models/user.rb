class User < ApplicationRecord
  rolify
  has_many :friend, :foreign_key => 'user_id'
  has_many :posts,  :foreign_key => 'user_id'
  has_many :friend_request, :foreign_key => 'user_id'
  has_many :statuses, :foreign_key => 'user_id'
  has_many :comments, :foreign_key => 'user_id'
  after_create :welcome_send
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def welcome_send
  	CustomDeviseMailer.welcome_send(self).deliver
  end

  private
  def set_default_role
  	self.add_role :user
  end
end
