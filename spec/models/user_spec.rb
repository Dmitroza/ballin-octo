require 'spec_helper'
require 'factory_girl'

# to run tests: bundle exec rspec --drb spec/models/user_spec.rb

describe User do
  describe "#login" do
  	it "is symbols before @ from Email" do
	  	user = FactoryGirl.create(:user, email: "vasya@example.com")
	  	user.login.should == 'vasya'
	  end
  end

  describe "#has_friend?" do
  	context "user has friend" do
  		it "is true" do
				user = FactoryGirl.create(:user)
		  	friend = FactoryGirl.create(:user)
		  	user.friends << friend
		  	user.has_friend?(friend).should == true
		  end
  	end
  	context "has no friends" do
  		it "is false" do
				user = FactoryGirl.create(:user)
		  	friend = FactoryGirl.create(:user)
	  		user.has_friend?(friend).should == false
	  	end
  	end
  end

	describe "#can_add_friend?" do
  	context "user has friend already" do
  		it "is false" do
		  	user = FactoryGirl.create(:user)
		  	friend = FactoryGirl.create(:user)
		  	user.friends << friend
		  	user.can_add_friend?(friend).should == false
		  end
  	end
  	context "user has no friends" do
  		it "is true" do
		  	user = FactoryGirl.create(:user)
		  	not_friend = FactoryGirl.create(:user)
	  		user.can_add_friend?(not_friend).should == true
			end
  	end
  end

	describe "#mutual_friendships" do
  	context "user and friend are mutual" do
  	 	it "is not empty" do
		  	user = FactoryGirl.create(:user)
		   	friend = FactoryGirl.create(:user)
		  	user.friends << friend
		  	friend.friends << user
		  	user.mutual_friendships.find {|f| f.friend == friend }.should be_present
		  	friend.mutual_friendships.find {|f| f.friend == user }.should be_present
		  end
  	end
  	context "friend as a friend for user" do
  		it "is empty" do
		  	user = FactoryGirl.create(:user)
		   	friend = FactoryGirl.create(:user)
		  	user.friends << friend
		  	user.mutual_friendships.find {|f| f.friend == friend }.should_not be_present
		  	friend.mutual_friendships.find {|f| f.friend == user }.should_not be_present

			end
  	end
  	context "friend as a subscriber for user" do
  		it "is empty" do
		  	user = FactoryGirl.create(:user)
		   	friend = FactoryGirl.create(:user)
		  	friend.friends << user
		  	user.mutual_friendships.find {|f| f.friend == friend }.should_not be_present
		  	friend.mutual_friendships.find {|f| f.friend == user }.should_not be_present
		  end
		end
  end

	describe "#notmutual_friendships" do
  	context "user and friend are mutual" do
  	 	it "is empty" do
		  	user = FactoryGirl.create(:user)
		   	friend = FactoryGirl.create(:user)
		  	user.friends << friend
		  	friend.friends << user
		  	user.notmutual_friendships.find {|f| f.friend == friend }.should_not be_present
		  	friend.notmutual_friendships.find {|f| f.friend == user }.should_not be_present
		  end
  	end
  	context "friend as a friend for user" do
  		it "is not empty for user only" do
		  	user = FactoryGirl.create(:user)
		   	friend = FactoryGirl.create(:user)
		  	user.friends << friend
		  	user.notmutual_friendships.find {|f| f.friend == friend }.should be_present
		  	friend.notmutual_friendships.find {|f| f.friend == user }.should_not be_present

			end
  	end
  	context "friend as a subscriber for user" do
  		it "is not empty for friend only" do
		  	user = FactoryGirl.create(:user)
		   	friend = FactoryGirl.create(:user)
		  	friend.friends << user
		  	user.notmutual_friendships.find {|f| f.friend == friend }.should_not be_present
		  	friend.notmutual_friendships.find {|f| f.friend == user }.should be_present
		  end
		end
  end

	describe "#my_subscribers" do
  	context "user and friend are mutual" do
  	 	it "is false" do
		  	user = FactoryGirl.create(:user)
		   	friend = FactoryGirl.create(:user)
		  	user.friends << friend
		  	friend.friends << user
		  	user.my_subscribers.include?(friend).should == false
		  	friend.my_subscribers.include?(user).should == false
		  end
  	end
  	context "friend as a friend for user" do
  		it "is true for friend only" do
		  	user = FactoryGirl.create(:user)
		   	friend = FactoryGirl.create(:user)
		  	user.friends << friend
		  	user.my_subscribers.include?(friend).should == false
		  	friend.my_subscribers.include?(user).should == true
			end
  	end
  	context "friend as a subscriber for user" do
  		it "is true for user only" do
		  	user = FactoryGirl.create(:user)
		   	friend = FactoryGirl.create(:user)
		  	friend.friends << user
		  	user.my_subscribers.include?(friend).should == true
		  	friend.my_subscribers.include?(user).should == false
		  end
		end
  end

end