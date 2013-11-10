class Person < ActiveRecord::Base
  validates :height, presence: true,
    numericality: { greater_than: 0 }
  validates :weight, presence: true,
    numericality: { greater_than: 0 }
  validates :gender, presence: true,
    inclusion: { in: %w(M F) }
end
