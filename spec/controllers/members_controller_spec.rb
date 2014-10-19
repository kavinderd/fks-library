require 'rails_helper'

RSpec.describe MembersController, :type => :controller do

  context "GET 'new'" do

    it "renders the new page" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a member object" do
      get :new
      expect(assigns(:member)).to_not be_nil
    end
  end

  context "POST 'create'" do

    context 'with valid attributes' do

      before(:each) do 
        @attrs = { name: 'Test', email: 'test@test.com' }
      end

      it "renders the show method for the member" do
        post :create, member: @attrs
        expect(:response).to redirect_to(assigns(:member))
      end
    end

    context 'with invalid attributes' do

      before(:each) do
        @attrs = {email: 'test@test.com'}
      end

      it "renders the new template" do
        post :create, member: @attrs
        expect(:response).to render_template(:new)
      end

    end
  end

end
