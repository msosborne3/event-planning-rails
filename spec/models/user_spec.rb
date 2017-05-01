require 'rails_helper'
require 'date'

RSpec.describe User, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:upcoming_event) { FactoryGirl.create(:event, time: (Time.now + 2)) }
  let(:past_event) { FactoryGirl.create(:event, time: (Time.now - 2)) }

  before(:each) {}

  it { should have_many (:event_rsvps) }

  it { should have_many (:events) }

  describe '.full_name' do
    it 'should return a users first and last name' do
      expect(user.full_name).to eq("#{user.first_name} " + "#{user.last_name}")
    end
  end 

  context 'rsvp_events' do
    before(:each) do 
      upcoming_event.add_rsvp(user)
      past_event.add_rsvp(user) 
    end

    describe '.upcoming_events' do
      it 'should return a list of events that a user has RSVPd to but have not happened' do
        expect(user.upcoming_events).to include(upcoming_event)
      end

      it 'should not include past events' do
        expect(user.upcoming_events).to_not include(past_event)
      end
    end

    describe '.past_events' do
      it 'should return a list of events that a user has RSVPd to and have already happened' do
        expect(user.past_events).to include(past_event)
      end

      it 'should not include upcoming events events' do
        expect(user.past_events).to_not include(upcoming_event)
      end
    end
  end
end