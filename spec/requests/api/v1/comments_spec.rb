require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
    parameter name: 'post_id', in: :path, type: :string, description: 'post_id'

    get('list comments') do
      response(200, 'successful') do
        let(:user_id) { '123' }
        let(:post_id) { '123' }

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

    post('create comment') do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })

      response(200, 'successful') do
        consumes 'application/json'
        security [Authorization: {}]
        let(:Authorization) { "Authorization #{generate_token}" }
        let(:author_id) { '123' }
        let(:post_id) { '123' }

        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            text: { type: :string },
            author_id: { type: :integer },
            post_id: { type: :integer }
          },
          required: %w[text author_id post_id]
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
end
