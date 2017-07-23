require 'rails_helper'

RSpec.describe ForumsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/forums').to route_to('forums#index')
    end

    it 'routes to #show' do
      expect(get: '/forums/1').to route_to('forums#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/forums').to route_to('forums#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/forums/1').to route_to('forums#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/forums/1').to route_to('forums#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/forums/1').to route_to('forums#destroy', id: '1')
    end

  end
end
