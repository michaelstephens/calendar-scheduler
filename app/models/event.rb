class Event < ActiveRecord::Base
  validates :title, :starts_at, :ends_at, presence: true
  serialize :attendees

  def to_s
    title
  end

end