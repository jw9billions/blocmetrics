class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, length: { minimum: 3, maximum: 30 }, presence: true
  validates :url, length: {minimum: 7, maximum: 100 }, presence: true
  validates_uniqueness_of :url, scope: :user
end
