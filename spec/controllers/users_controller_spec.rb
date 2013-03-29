require 'spec_helper'
# to run tests: bundle exec rspec --drb spec/controllers/users_controller_spec.rb

describe UsersController do

	before(:each) do
		@admin = FactoryGirl.create(:admin)
    sign_in @admin
  end

  describe "GET #index?" do
  	it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.code).to eq("200")
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the users into @users" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      get :index
      expect(assigns(:users)).to match_array([@admin, user1, user2])
    end
  end

end