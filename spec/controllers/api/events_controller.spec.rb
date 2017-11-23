require 'rails_helper'

RSpec.describe API::EventsController, type: :controller do

  before(:each) do
    @my_user = FactoryGirl.create(:user)
    sign_in @my_user
    @my_app = FactoryGirl.create(:registered_application, user: @my_user)
    controller.request.env['HTTP_ORIGIN'] = @my_app.url
  end

  describe "OPTIONS show" do
    it 'returns the response CORS headers' do
      post :create, event: { name: "About Page Load"}
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
    end
  end

  describe "POST create" do
    it "increases the number of events by 1" do
      expect{ post :create, :event => { :name => "MyApp1"} }.to change(Event, :count).by(1)
    end
  end
end
