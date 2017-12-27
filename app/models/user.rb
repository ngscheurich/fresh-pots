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

  belongs_to :pot, optional: true
  belongs_to :variety, optional: true
  has_many :brews

  def self.most_active
    User.order(brews_count: :desc).first
  end

  def full_name=(name)
    split = name.split(" ")
    self.first_name = split.first
    self.last_name = split.last
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def favorite_pot
    pot || Pot.first
  end

  def favorite_variety
    variety || Variety.first
  end

  def num_brews_this_week
    brews.where("created_at >= '#{Time.zone.today.beginning_of_week}'").count
  end
end
