require 'rails_helper'

RSpec.describe 'todos', type: :request do
  it 'lists todos' do
    user = User.create!(email: 'example@example.com', password: 'password')
    todo1 = Todo.create!(title: 'Todo 1', user: user)
    todo2 = Todo.create!(title: 'Todo 2', user: user)

    get '/todos'

    expect(response).to be_successful

    response_todos = JSON.parse(response.body)

    expect(response_todos.length).to eq(2)
    expect(response_todos.first['title']).to eq('Todo 1')
  end

  describe 'creating todos' do
    it 'fails without authentication' do
      body = { title: 'New Todo' }

      post '/todos', params: body

      expect(response.status).to eq(401)
      expect(Todo.count).to eq(0)
    end

    it 'creates a todo with authentication' do
      user = User.create!(email: 'example@example.com', password: 'password')
      token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id)

      headers = { 'Authorization' => "Bearer #{token.token}" }
      body = { title: 'New Todo' }

      post '/todos', params: body, headers: headers

      expect(response.status).to eq(201)
      expect(Todo.count).to eq(1)
      expect(Todo.first.title).to eq('New Todo')
    end

    it 'validates required fields' do
      user = User.create!(email: 'example@example.com', password: 'password')
      token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id)

      headers = { 'Authorization' => "Bearer #{token.token}" }
      body = { title: '' }

      post '/todos', params: body, headers: headers

      expect(response.status).to eq(422)

      response_errors = JSON.parse(response.body)

      expect(response_errors['title']).to eq(["can't be blank"])
    end
  end
end
