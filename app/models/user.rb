class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, s3_region: ENV["aws_region"]

  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}

  def self.most_active
    User.order(brews_count: :desc).first
  end

  def avatar_with_fallback
    self[:avatar] || "https://api.adorable.io/avatars/200/#{email}"
  end
end
