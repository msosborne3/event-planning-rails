require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user_id: user.id) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }

  before(:each) { event.add_rsvp(user2) }

  it { should belong_to(:user) }

  it { should have_many(:event_rsvps) }

  describe '.add_rsvp' do
    it 'should rsvp a user to an event' do
      expect(event.attendees).to include(user2)
    end
  end

  describe '.remove_rsvp' do
    it 'should remove a user from the event_rsvps list' do
      event.remove_rsvp(user2)
      expect(event.attendees).to_not include(user2)
    end
  end

  describe '.attending?' do

    it 'should return true if a user has RSVPd to the event' do
      expect(user2).to be_attending(event)
    end

    it 'should return false if a user has not not RSVPd to the event' do
      expect(user3).to_not be_attending(event)
    end
  end
  
end
