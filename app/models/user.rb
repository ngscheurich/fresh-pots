class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, s3_region: ENV["aws_region"]

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
