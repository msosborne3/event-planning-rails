require 'rails_helper'
require 'date'

RSpec.describe User, type: model do

  let(:user) { FactoryGirl.create(:user) }
  let(:upcoming_concert) { FactoryGirl.create(:concert, date: (Date.today + 1), user_id: user.id)}
  let(:past_concert) { FactoryGirl.create(:concert, date: (Date.today - 1), user_id: user.id)}
  
  it { should have_many (:rsvp_events) }

  it { should have_many (:created_events) }

  describe '.full_name' do
    it 'should return a users first and last name' do
      expect(user.full_name).to eq("#{user.first_name}" + "#{user.last_name}")
    end
  end 

  describe '.upcoming_concerts' do
    it 'should return a list of concerts that a user has RSVPd to but have not happened' do
      expect(user.upcoming_concerts).to include(upcoming_concert)
    end

    it 'should not include past concerts' do
      expect(user.upcoming_concert).to_not include(past_concert)
    end
  end


  describe '.past_concerts' do
    it 'should return a list of concerts that a user has RSVPd to and have already happened' do
      expect(user.past_concerts).to include(past_concert)
    end

    it 'should not include upcoming_concerts concerts' do
      expect(user.past_concerts).to_not include(upcoming_concert)
    end
  end

end