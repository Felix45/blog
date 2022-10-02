require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users' do
    get('list users') do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })

      response(200, 'successful') do
        security [Authorization: {}]
        let(:Authorization) { "Authorization #{generate_token}" }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create user') do
      response(200, 'successful') do
        consumes 'application/json'

        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string },
            bio: { type: :string },
            password: { type: :string },
            password_confirmation: { type: :string }
          },
          required: %w[name email bio password password_confirmation]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    # You'll want to customize the parameter types...
    parameter({
                in: :header,
                type: :string,
                name: :Authorization,
                required: true,
                description: 'Client token'
              })
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      response(200, 'successful') do
        security [Authorization: {}]
        let(:Authorization) { "Authorization #{generate_token}" }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
