class Turnpoint < ApplicationRecord
  belongs_to :group

  scope :sorted, -> { order(sort_order: :asc) }
  scope :active, -> { where(active: true) }
end
