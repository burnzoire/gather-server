require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    allow(controller).to receive(:authenticate).and_return(true)
  end

  describe 'GET #index' do
    let!(:user) { FactoryGirl.create(:user) }

    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    let!(:user) { FactoryGirl.create(:user) }

    it 'returns a success response' do
      get :show, params: { id: user.to_param }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      subject do
        post :create, params: { user: FactoryGirl.attributes_for(:user) }
      end
      it 'creates a new User' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        subject
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(user_url(User.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new user' do
        post :create, params: { user: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { FactoryGirl.create(:user) }

    it 'destroys the requested user' do
      expect { delete :destroy, params: { id: user.to_param } }.to change(User, :count).by(-1)
    end
  end

end
