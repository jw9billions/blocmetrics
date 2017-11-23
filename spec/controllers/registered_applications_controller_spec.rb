require 'rails_helper'

RSpec.describe RegisteredApplicationsController, type: :controller do

  before(:each) do
    @my_user = FactoryBot.create(:user)
    sign_in @my_user
    @my_app= FactoryBot.create(:registered_application, user: @my_user)
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the #index view" do
      get :index
      expect(response).to render_template :index
    end
  end


  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @registered_application" do
      get :new
      expect(assigns(:registered_application)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of registered apps by 1" do
      expect{ post :create, :registered_application => { :name => "MyApp1", :url => "http://localhost/myapp1", :user => @my_user } } .to change(RegisteredApplication, :count).by(1)
    end

    it "assigns the registered app to @registered_application" do
      post :create, :registered_application => { :name => "MyApp1", :url => "http://localhost/myapp1", :user => @my_user }
      expect(assigns(:registered_application)).to eq RegisteredApplication.last
    end

    it "redirects to the index page" do
      post :create, :registered_application => { :name => "MyApp1", :url => "http://localhost/myapp1", :user => @my_user }
      expect(response).to redirect_to registered_applications_path
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, id: @my_app.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, id: @my_app.id
      expect(response).to render_template :show
    end

    it "assigns @my_wiki to @wiki" do
      get :show, id: @my_app.id
      expect(assigns(:registered_application)).to eq(@my_app)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, id: @my_app.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, id: @my_app.id
      expect(response).to render_template :edit
    end

    it "assigns @registered_application to be updated to updated_app" do
      get :edit, id: @my_app.id
      updated_app = assigns(:registered_application)

      expect(updated_app.id).to eq @my_app.id
      expect(updated_app.name).to eq @my_app.name
      expect(updated_app.url).to eq @my_app.url
    end
  end

  describe "PUT update" do
    it "updates app with expected attributes" do
      new_name = "MyApp4"
      new_url = "http://myapp4"

      put :update, id: @my_app.id, :registered_application => { :name => new_name, :url => new_url, :user => @my_user }

      updated_app = assigns(:registered_application)
      expect(updated_app.id).to eq @my_app.id
      expect(updated_app.name).to eq new_name
      expect(updated_app.url).to eq new_url
    end

    it "redirects to the index page" do
      new_name = "MyApp4"
      new_url = "http://myapp4"

      put :update, id: @my_app.id, :registered_application => { :name => new_name, :url => new_url, :user => @my_user }
      expect(response).to redirect_to registered_application_path(@my_app)
    end
  end

  describe "DELETE destroy" do
    it "deletes the app" do
      delete :destroy, id: @my_app.id
      count = RegisteredApplication.where({id: @my_app.id}).size
      expect(count).to eq 0
    end

    it "redirects to Apps index page" do
      delete :destroy, id: @my_app.id
      expect(response).to redirect_to registered_applications_path
    end
  end

end
