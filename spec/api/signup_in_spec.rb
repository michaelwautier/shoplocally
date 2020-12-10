require 'rails_helper'

describe '# Sign up', type: :request do
  it 'Should return status http status 201 and a token when successfully signed up' do
    post 'api/v1/signup', params: {
      first_name: 'Karel',
      last_name: 'Asselman',
      email: 'karel@karel.com',
      password: '1234567'
    }

    expect(response).to have_http_status :created
    expect(JSON.parse(response.body)).to include :token
  end

  it 'Should return status 422 when no or incorrect user params provided' do
    post 'api/v1/signup', params: {}
    expect(response).to have_http_status :unprocessable_entity
  end
end

describe '# Sign in', type: :request do
  it 'Should return status http status 200 and a token when successfully signed in' do
    post 'api/v1/signup', params: { email: 'karel@karel.com', password: '1234567' }

    expect(response).to have_http_status :ok
    expect(JSON.parse(response.body)).to include :token
  end

  it 'Should return status http status 401 when no or incorrect user params provided' do
    post 'api/v1/signup', params: { email: 'incorrect@email.com', password: '1234567' }
    expect(response).to have_http_status :unauthorized
  end
end
