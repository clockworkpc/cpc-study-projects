# frozen_string_literal: true

require 'swagger_helper'

describe 'Wines Admin API', type: :request, swagger_doc: 'api/swagger_admin_doc.json' do
  TAGS_ADMIN_WINES = Wines.freeze
  path '/api/admin/wines' do
    get 'Retrieves all wines. By Author' do
      tags TAGS_ADMIN_WINES
      produces 'application/json'

      response '200', 'Wines found' do
        before { create_list(:wine, 2) } # if you have a factory to create models (cf gem FactoryBot)

        include_context 'with integration test'
      end
    end
  end
end
