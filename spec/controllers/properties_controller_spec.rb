require 'spec_helper'
# to run tests: bundle exec rspec --drb spec/controllers/properties_controller_spec.rb

describe PropertiesController do

	before(:each) do
		@user = FactoryGirl.create(:user)
    sign_in @user
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
      prop1 = FactoryGirl.build(:property)
      prop1.owner = @user
      prop1.save
      prop2 = FactoryGirl.build(:property)
      prop2.owner = @user
      prop2.save
      get :index
      expect(assigns(:properties)).to match_array([prop1, prop2])
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      prop = FactoryGirl.create(:property, :owner => @user)
      get :show, id: prop
      expect(response).to be_success
      expect(response.code).to eq("200")
    end
    it "renders the show template" do
      prop = FactoryGirl.create(:property, :owner => @user)
      get :show, id: prop
      expect(response).to render_template("show")
    end
    it "loads all of the users into @properties" do
      prop = FactoryGirl.create(:property, :owner => @user)
      get :show, id: prop
      assigns(:property).should eq(prop)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new property" do
        expect{          
          post :create, property: FactoryGirl.attributes_for(:property)
        }.to change(Property,:count).by(1)
      end
      
      it "redirects to the root path" do
        post :create, property: FactoryGirl.attributes_for(:property)
        response.should redirect_to root_path
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new property" do
        expect{
          post :create, property: FactoryGirl.attributes_for(:property, :city => nil)
        }.to_not change(Property,:count)
      end
      
      it "re-renders the new method" do
        post :create, property: FactoryGirl.attributes_for(:property, :city => nil)
        response.should render_template :new
      end
    end 
  end

  describe 'DELETE #destroy' do
    before :each do
      @admin = FactoryGirl.create(:admin)
      @admprop = FactoryGirl.create(:property, :owner => @admin)
      @prop = FactoryGirl.create(:property, :owner => @user)
    end
    
    context "user can manage property" do
      it "deletes the property" do
        expect{
          delete :destroy, id: @prop        
        }.to change(Property,:count).by(-1)
      end
        
      it "redirects to properties#index" do
        delete :destroy, id: @prop
        response.should redirect_to root_path
      end
    end
    
    context "user can't manage property" do 
      it "deletes the property" do
        expect{
          delete :destroy, id: @admprop        
        }.to_not change(Property,:count)
      end
        
      it "redirects to 403" do
        delete :destroy, id: @admprop
        response.code.should == "403"
      end
    end

  end

end