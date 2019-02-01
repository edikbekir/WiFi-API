class Event < ApplicationRecord
  before_create :set_end_time

  validates :start_time, presence: true

  has_many :event_visitors
  has_many :visitors, through: :event_visitors

  DEFAULT_EVENT_DURATION = 1.5.hours

  def actual?
    true if self.end_time > Time.current #&& ((self.end_time - Time.current) < 15.minutes)
  end

  def set_end_time
    self.end_time = self.start_time + DEFAULT_EVENT_DURATION
  end
end
