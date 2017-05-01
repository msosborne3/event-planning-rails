class Event < ApplicationRecord
  belongs_to :user
  has_many :event_rsvps

  def attendees
    attendees = self.event_rsvps.map do |rsvp|
      User.find_by(id: rsvp.user_id)
    end
  end

  def add_rsvp(user)
    EventRsvp.create(event_id: self.id, user_id: user.id)
  end

  def remove_rsvp(user)
    self.event_rsvps.find_by(user_id: user.id).destroy
  end
end
