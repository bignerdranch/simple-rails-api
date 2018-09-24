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
end
