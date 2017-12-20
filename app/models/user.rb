class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file(
    :avatar,
    s3_region: ENV["aws_region"],
    default_url: lambda do |a|
      "https://api.adorable.io/avatars/200/#{a.instance.email}"
    end
  )

  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}

  def self.most_active
    User.order(brews_count: :desc).first
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
