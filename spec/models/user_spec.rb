require 'spec_helper'

describe User do
  
  describe "validations" do

    it 'should generate an auth token upon user creation' do
      u = FactoryGirl.create(:defaulted_user)
      u.authentication_token.present?.should == true
    end
       
  end

  describe "methods" do
    
    it "should have the auth token expire" do
      u = FactoryGirl.create(:defaulted_user, authentication_token: "authtoken")
      u.authentication_token.should == "authtoken"
      u.token_expired?.should == false
      Timecop.travel(8.days.from_now)
      u.authentication_token.should == "authtoken"
      u.token_expired?.should == true
      Timecop.return
    end

    it "should generate a new auth token and set token_generated_at to the current time" do
      u = FactoryGirl.create(:defaulted_user, authentication_token: "authtoken")
      u.authentication_token.should == "authtoken"
      User.generate_new_auth_token(u)
      u.authentication_token.should_not == "authtoken"
    end

  end

  describe "before create" do
    
    it "should set a default token_generated_at" do
      u = FactoryGirl.create(:defaulted_user)
      u.token_generated_at.present?.should == true
    end

  end

end
