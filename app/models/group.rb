class Group < ApplicationRecord
  has_many :user_groupings, dependent: :destroy
  has_and_belongs_to_many :users, join_table: 'user_groupings'

  accepts_nested_attributes_for :user_groupings

  has_many :turnpoints

  validates :name, presence: true
end

