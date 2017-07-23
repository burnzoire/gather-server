require 'rails_helper'

RSpec.describe OrganisationsController, type: :controller do

  before(:each) do
    allow(controller).to receive(:authenticate).and_return(true)
  end

  let!(:organisation) { FactoryGirl.create(:organisation) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: organisation.to_param }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      subject { post :create, params: { organisation: { name: 'new organisation' } } }

      it 'creates a new Organisation' do
        expect { subject }.to change(Organisation, :count).by(1)
      end

      it 'renders a JSON response with the new organisation' do
        subject
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(organisation_url(Organisation.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new organisation' do
        post :create, params: { organisation: { foo: 'bar' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_name) { 'new organisation' }

      subject { put :update, params: { id: organisation.to_param, organisation: { name: new_name } } }

      it 'updates the requested organisation' do
        expect { subject }.to change { organisation.reload.name }.to new_name
      end

      it 'renders a JSON response with the organisation' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the organisation' do
        put :update, params: { id: organisation.to_param, organisation: { name: '', foo: 'bar' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested organisation' do
      expect { delete :destroy, params: { id: organisation.to_param } }.to change(Organisation, :count).by(-1)
    end
  end

end
