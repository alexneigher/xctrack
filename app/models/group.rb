class Group < ActiveRecord::Base
  has_many :user_groupings, dependent: :destroy
  has_and_belongs_to_many :users, join_table:'user_groupings'

  validates :name, presence: true
end

