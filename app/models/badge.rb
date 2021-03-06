class Badge < ActiveRecord::Base
  belongs_to :badge_type
  has_many :user_badges, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :badge_type, presence: true
  validates :allow_title, inclusion: [true, false]
  validates :multiple_grant, inclusion: [true, false]

  def self.trust_level_badge_ids
    (1..4).to_a
  end

  def reset_grant_count!
    self.grant_count = UserBadge.where(badge_id: id).count
    save!
  end

  def single_grant?
    !self.multiple_grant?
  end

end

# == Schema Information
#
# Table name: badges
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  description    :text
#  badge_type_id  :integer          not null
#  grant_count    :integer          default(0), not null
#  created_at     :datetime
#  updated_at     :datetime
#  allow_title    :boolean          default(FALSE), not null
#  multiple_grant :boolean          default(FALSE), not null
#  icon           :string(255)      default("fa-certificate")
#
# Indexes
#
#  index_badges_on_badge_type_id  (badge_type_id)
#  index_badges_on_name           (name) UNIQUE
#
