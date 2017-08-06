require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  before(:each) do
    allow(controller).to receive(:authenticate).and_return(true)
  end

  let!(:message) { FactoryGirl.create(:message, postable: topic) }
  let!(:topic) { FactoryGirl.create(:topic) }
  let!(:user) { FactoryGirl.create(:user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: message.to_param }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { { content: 'lol', postable_id: topic.id, postable_type: 'Topic', user_id: user.id } }

      it 'creates a new Message' do
        expect { post :create, params: { message: valid_attributes } }.to change(Message, :count).by(1)
      end

      it 'renders a JSON response with the new message' do
        post :create, params: { message: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(message_url(Message.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new message' do
        post :create, params: { message: { foo: 'bar' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { content: ':trollface:' } }

      it 'updates the requested message' do
        put :update, params: { id: message.to_param, message: new_attributes }
        message.reload
        expect(message.content).to eq(new_attributes[:content])
      end

      it 'renders a JSON response with the message' do
        put :update, params: { id: message.to_param, message: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the message' do
        put :update, params: { id: message.to_param, message: { content: '', foo: 'bar' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested message' do
      expect { delete :destroy, params: { id: message.to_param } }.to change(Message, :count).by(-1)
    end
  end

end
