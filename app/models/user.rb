class User < ActiveRecord::Base
  has_many :xml_files, dependent: :destroy
  has_many :pathfinder_decks, dependent: :destroy
  has_many :campaign_memberships, dependent: :destroy
  has_many :campaigns, through: :campaign_memberships, dependent: :destroy
  has_many :campaign_invitations, foreign_key: :recipient_email, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
