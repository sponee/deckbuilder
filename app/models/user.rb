class User < ActiveRecord::Base
  has_many :xml_files
  has_many :pathfinder_decks
  has_many :campaign_memberships
  has_many :campaigns, through: :campaign_memberships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
