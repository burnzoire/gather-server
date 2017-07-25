require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  before(:each) do
    allow(controller).to receive(:authenticate).and_return(true)
  end

  let!(:topic) { FactoryGirl.create(:topic, forum: forum, user: user) }
  let!(:forum) { FactoryGirl.create(:forum) }
  let!(:user) { FactoryGirl.create(:user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: topic.to_param }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { { topic: { title: 'dank memes', forum_id: forum.id, user_id: user.id } } }
      it 'creates a new Topic' do
        expect { post :create, params: params }.to change(Topic, :count).by(1)
      end

      it 'renders a JSON response with the new topic' do
        post :create, params: params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(topic_url(Topic.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new topic' do
        post :create, params: { topic: { foo: 'bar' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:updated_topic) { { title: 'upodated title' } }
      it 'updates the requested topic' do
        put :update, params: { id: topic.to_param, topic: updated_topic }
        topic.reload
        expect(topic.title).to eq(topic.title)
      end

      it 'renders a JSON response with the topic' do
        put :update, params: { id: topic.to_param, topic: updated_topic }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the topic' do
        put :update, params: { id: topic.to_param, topic: { title: '', foo: 'bar' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested topic' do
      expect { delete :destroy, params: { id: topic.to_param } }.to change(Topic, :count).by(-1)
    end
  end

end
