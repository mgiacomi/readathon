class Challenge < ActiveRecord::Base

  has_and_belongs_to_many :students, -> { uniq }

  scope :daily_challenge, lambda {
    day_idx = days_remaining
    Challenge.find(day_idx < 0 ? 0 : day_idx)
  }

  def self.days_remaining
    (Rails.configuration.end_date - Time.zone.today).to_i
  end

end