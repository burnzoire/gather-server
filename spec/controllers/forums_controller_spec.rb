require 'rails_helper'

RSpec.describe ForumsController, type: :controller do

  before(:each) do
    allow(controller).to receive(:authenticate).and_return(true)
  end

  let!(:forum) { FactoryGirl.create(:forum, organisation: organisation) }
  let!(:organisation) { FactoryGirl.create(:organisation) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: forum.to_param }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      subject { post :create, params: { forum: { name: 'cool new forum', organisation_id: organisation.id } } }

      it 'creates a new Forum' do
        expect { subject }.to change(Forum, :count).by(1)
      end

      it 'renders a JSON response with the new forum' do
        subject
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(forum_url(Forum.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new forum' do
        post :create, params: { forum: { foo: 'bar' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_name) { 'awesome forum' }

      subject { put :update, params: { id: forum.to_param, forum: { name: new_name } } }

      it 'updates the requested forum' do
        expect { subject }.to change { forum.reload.name }.to new_name
      end

      it 'renders a JSON response with the forum' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the forum' do
        put :update, params: { id: forum.to_param, forum: { name: '', foo: 'bar' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested forum' do
      expect { delete :destroy, params: { id: forum.to_param } }.to change(Forum, :count).by(-1)
    end
  end

end
