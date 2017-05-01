class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  has_many :event_rsvps

  def full_name
    full_name = first_name + ' ' + last_name
  end

  def upcoming_events
    upcoming = []
    self.event_rsvps.each do |rsvp|
      event = Event.find_by(id: rsvp.event_id)
      if event.time >= Time.now
        upcoming << event
      end
    end
    upcoming
  end

  def past_events
    past = []
    self.event_rsvps.each do |rsvp|
      event = Event.find_by(id: rsvp.event_id)
      if event.time < Time.now
        past << event
      end
    end
    past
  end

  def attending?(event)
    event = self.event_rsvps.find_by(event_id: event.id)
    event ? true : false
  end
end
