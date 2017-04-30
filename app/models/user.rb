class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  has_many :rsvp_events, class_name: 'Event'

  def full_name
    full_name = first_name + ' ' + last_name
  end

  def upcoming_events
    self.events.map { |event| event.date >= today }
  end

  def past_events
    self.events.map { |event| event.date < today }
  end
end
