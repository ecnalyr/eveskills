require 'spec_helper'

describe ApiKeysController do

  login_user

  # Eve api keys should have an access mask of 393224
  eve_api_identifier = "1867200"
  verification_code = "oReWk9nG5QutSKn03RINpBXajnDtU2egla3uTr4dLQDV4kVTeQodWgy1He7ECeU4"

  eve_api_identifier_no_skill_in_training = "1878387"
  verification_code_no_skill_in_training = "N918tK4e6MH1D6R61JjPuyxsylg9o2TIrdtuAK6mwhNW3zWy1KTZH7946jY2aV1L"

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  describe "GET index" do
    it "assigns all api_keys as @api_keys" do
      api_key = FactoryGirl.create(:api_key)
      get :index, {}
      assigns(:api_keys).should eq([api_key])
    end
  end

  describe "GET show" do
    it "assigns the requested api_key as @api_key" do
      api_key = FactoryGirl.create(:api_key)
      get :show, {:id => api_key.to_param}
      assigns(:api_key).should eq(api_key)
    end
  end

  describe "GET new" do
    it "assigns a new api_key as @api_key" do
      get :new, {}
      assigns(:api_key).should be_a_new(ApiKey)
    end
  end

  describe "GET edit" do
    it "assigns the requested api_key as @api_key" do
      api_key = FactoryGirl.create(:api_key)
      get :edit, {:id => api_key.to_param}
      assigns(:api_key).should eq(api_key)
    end
  end

  describe "POST create" do
      it "creates a new ApiKey" do
        expect {
          post :create, :api_key => FactoryGirl.attributes_for(:api_key)
        }.to change(ApiKey, :count).by(1)
      end

      it "assigns a newly created api_key as @api_key" do
        post :create, :api_key => FactoryGirl.attributes_for(:api_key)
        assigns(:api_key).should be_a(ApiKey)
        assigns(:api_key).should be_persisted
      end

      it "redirects to the created api_key" do
        post :create, :api_key => FactoryGirl.attributes_for(:api_key)
        response.should redirect_to(ApiKey.last)
      end

    describe "with invalid params" do
      it "assigns a newly created but unsaved api_key as @api_key" do
        post :create, {:api_key => { "id" => "invalid value" }}
        assigns(:api_key).should be_a_new(ApiKey)
      end

      it "re-renders the 'new' template" do
        ApiKey.any_instance.stub(:save).and_return(false)
        post :create, {:api_key => { "id" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested api_key" do
        api_key = FactoryGirl.create(:api_key)
        # Assuming there are no other api_keys in the database, this
        # specifies that the ApiKey created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ApiKey.any_instance.should_receive(:update_attributes).with({ "verification_code" => "MyString"})
        put :update, {:id => api_key.to_param, :api_key => { "verification_code" => "MyString" }}
      end

      it "assigns the requested api_key as @api_key", :vcr do
        api_key = FactoryGirl.create(:api_key)
        put :update, {:id => api_key.to_param, 
            :api_key => { "eve_api_identifier" => eve_api_identifier, 
                          "verification_code" => verification_code, 
                          "user_id" => "1"}}
        assigns(:api_key).should eq(api_key)
      end

      it "redirects to the api_key", :vcr do
        api_key = FactoryGirl.create(:api_key)
        put :update, {:id => api_key.id.to_param,
            :api_key => { "eve_api_identifier" => eve_api_identifier, 
                            "verification_code" => verification_code, 
                            "user_id" => "1"}}
        response.should redirect_to(api_key)
      end
    end

    describe "with invalid params" do
      it "assigns the api_key as @api_key" do
        api_key = FactoryGirl.create(:api_key)
        ApiKey.any_instance.stub(:save).and_return(false)
        put :update, {:id => api_key.to_param, :api_key => { "verification_code" => "YourString"}}
        assigns(:api_key).should eq(api_key)
      end

      it "re-renders the 'edit' template" do
        api_key = FactoryGirl.create(:api_key)
        ApiKey.any_instance.stub(:save).and_return(false)
        put :update, {:id => api_key.to_param, :api_key => { "verification_code" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested api_key" do
      api_key = FactoryGirl.create(:api_key)
      expect {
        delete :destroy, {:id => api_key.to_param}
      }.to change(ApiKey, :count).by(-1)
    end

    it "redirects to the api_keys list" do
      api_key = FactoryGirl.create(:api_key)
      delete :destroy, {:id => api_key.to_param}
      response.should redirect_to(api_keys_url)
    end
  end

  describe "pull_data" do
    it "udpates api_key.char_data with data from Eve online", :vcr, record: :all do
      api_key = FactoryGirl.create(:api_key, :skill_is_training)
      # Assuming there are no other api_keys in the database. . .
      ApiKey.any_instance.should_receive(:populate_char_sheet)
      put :pull_data, {:id => api_key.to_param}
      ApiKey.any_instance.should_not be_nil 
    end

    it "should redirect to the api_key after a successful pull of api data", :vcr, record: :all do
      api_key = FactoryGirl.create(:api_key, :skill_is_training)
      put :pull_data, {:id => api_key.to_param}
      response.should redirect_to(api_key)
    end
  end

end
