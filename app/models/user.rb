class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :nickname, presence: true, length: { maximum: 10 }

  has_many :projects, dependent: :destroy
  has_many :user_returns, dependent: :destroy
  has_many :returns, through: :user_returns
  has_many :likes, dependent: :destroy
  has_many :projecs, through: :likes
  mount_uploader :avatar, AvatarUploader

  def project_owner?(project)
    self.projects.exists?(project.id)
  end
end
