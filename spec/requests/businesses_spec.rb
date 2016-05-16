require 'rails_helper'

RSpec.describe 'Businesses', type: :request do
  describe 'GET /businesses' do
    it 'Should get first 50 businesses by default' do
      get '/businesses'
      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['businesses'].length).to eq(50)
    end

    it 'Should return correct paginated metadata' do
      get '/businesses'
      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['meta']['current_page']).to eq(1)
      expect(json_response['meta']['next_page']).to eq(2)
      expect(json_response['meta']['prev_page']).to be_nil
      expect(json_response['meta']['total_pages']).to eq(1_000)
      expect(json_response['meta']['total_count']).to eq(50_000)
    end

    it 'Should paginate all the businesses using the per_page parameter' do
      get '/businesses', per_page: 20
      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['businesses'].length).to eq(20)
    end

    it 'Should get to the paginated page using the page parameter' do
      get '/businesses', page: 2
      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['meta']['current_page']).to eq(2)
    end

    it 'Should paginate using both per_page & page parameters' do
      get '/businesses', per_page: 20, page: 2
      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['meta']['current_page']).to eq(2)
      expect(json_response['businesses'].length).to eq(20)
    end

    it 'Should get different metadata with per_page & page parameters' do
      get '/businesses', per_page: 20, page: 2
      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['meta']['current_page']).to eq(2)
      expect(json_response['meta']['next_page']).to eq(3)
      expect(json_response['meta']['prev_page']).to eq(1)
      expect(json_response['meta']['total_pages']).to eq(2_500)
      expect(json_response['meta']['total_count']).to eq(50_000)
    end
  end

  describe 'GET /businesses/:id' do
    it 'Should find & show the businesses that matches the id' do
      get '/businesses/1'
      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['business']['id']).to eq(1)
    end

    it 'Should return 404 error where business does not exist' do
      get '/businesses/55000'
      expect(response.body).to include(
        "Couldn't find Business with 'id'=55000"
      )
      expect(response).to have_http_status(404)
    end
  end
end
