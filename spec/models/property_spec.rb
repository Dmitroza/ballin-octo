require 'spec_helper'
require 'factory_girl'
# to run tests: bundle exec rspec --drb spec/models/property_spec.rb


describe User do

  describe "#owned_by?" do
  	context "owner" do
	  	it "is true" do
		  	owner = FactoryGirl.create(:user)
		  	property = FactoryGirl.build(:property)
		  	property.owner = owner
		  	property.save!
		  	property.owned_by?(owner).should == true
		  end
		end
  	context "not owner" do
	  	it "is false" do
		  	owner = FactoryGirl.create(:user)
		  	user = FactoryGirl.create(:user)
		  	property = FactoryGirl.build(:property)
		  	property.owner = user
		  	property.save!
		  	property.owned_by?(owner).should == false
		  end
		end
  end

  describe "#belongs_to_friend?" do
  	context "friend is owner" do
	  	it "is true" do
		  	user = FactoryGirl.create(:user)
		  	friend = FactoryGirl.create(:user)
		  	property = FactoryGirl.build(:property)
		  	property.owner = friend
		  	property.save!
		  	user.friends << friend		  	
		  	property.belongs_to_friend?(user).should == true
		  end
		end
  	context "friend is not owner" do
	  	it "is false" do
		  	user = FactoryGirl.create(:user)
		  	friend = FactoryGirl.create(:user)
		  	property = FactoryGirl.build(:property)
		  	property.owner = user
		  	property.save!
		  	user.friends << friend
		  	property.belongs_to_friend?(user).should == false
		  end
		end
  end

  describe "#can_manage_property?" do
  	context "user is owner" do
	  	it "is true" do
		  	user = FactoryGirl.create(:user)
		  	property = FactoryGirl.build(:property)
		  	property.owner = user
		  	property.save!
		  	property.can_manage_property?(user).should be_true
		  end
		end
  	context "user is ADMIN and owner" do
	  	it "should be true" do
		  	user = FactoryGirl.create(:admin)
		  	property = FactoryGirl.build(:property)
		  	property.owner = user
		  	property.save!
		  	property.can_manage_property?(user).should == true
		  end
		end
  	context "user is not owner" do
	  	it "should be false" do
		  	user = FactoryGirl.create(:user)
		  	friend = FactoryGirl.create(:user)
		  	property = FactoryGirl.build(:property)
		  	property.owner = friend
		  	property.save!
		  	property.can_manage_property?(user).should == false
		  end
		end
  end
  	context "user is ADMIN and not owner" do
	  	it "should be true" do
		  	user = FactoryGirl.create(:admin)
		  	friend = FactoryGirl.create(:user)
		  	property = FactoryGirl.build(:property)
		  	property.owner = friend
		  	property.save!
		  	property.can_manage_property?(user).should == true
		  end
		end

end