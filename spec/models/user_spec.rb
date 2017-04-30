require 'rails_helper'
require 'date'

RSpec.describe User, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  #let(:upcoming_event) { FactoryGirl.create(:event, date: (Date.today + 1), user_id: user.id) }
  #let(:past_event) { FactoryGirl.create(:event, date: (Date.today - 1), user_id: user.id) }
  
  let(:event) { FactoryGirl.create(:event, user_id: user.id) }

  it { should have_many (:rsvp_events) }

  it { should have_many (:events) }

  describe '.full_name' do
    it 'should return a users first and last name' do
      expect(user.full_name).to eq("#{user.first_name} " + "#{user.last_name}")
    end
  end 

  # TO DO: implement event with a .rsvp method to add it to a user's list
  # Then test for it

  #describe '.upcoming_events' do
  #  it 'should return a list of events that a user has RSVPd to but have not happened' do
  #    expect(user.upcoming_events).to include(upcoming_event)
  #  end
#
  #  it 'should not include past events' do
  #    expect(user.upcoming_events).to_not include(past_event)
  #  end
  #end

  #describe '.past_events' do
  #  it 'should return a list of events that a user has RSVPd to and have already happened' do
  #    expect(user.past_events).to include(past_event)
  #  end
#
  #  it 'should not include upcoming events events' do
  #    expect(user.past_events).to_not include(upcoming_event)
   # end
  #end


  describe '.events' do
    it 'should list all of a users created events' do
      expect(user.events.length).to eq(1)
    end
  end

end