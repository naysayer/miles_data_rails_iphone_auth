require 'spec_helper'

describe User do
  describe "validations" do

    it 'should generate an auth token upon user creation' do
      u = FactoryGirl.create(:defaulted_user)
      u.authentication_token.present?.should == true
    end
       
  end

  describe "features" do
    
    it "should reset the auth token after a certain ammout of time" do
      u = FactoryGirl.create(:defaulted_user)
      token = u.authentication_token
      puts token
      Timecop.travel(3.days.from_now)
      u = User.first
      u.authentication_token.should == token
      puts u.authentication_token
      Timecop.return
    end

  end
end
