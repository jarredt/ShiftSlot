require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe '#index' do
    it 'assigns the @users variable' do
      get :index
      expect(assigns(:users)).to all be_a(User)
    end
    it 'responds with a status of 200' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'renders the index page' do
      expect(get :index).to render_template(:index)
    end
  end

  describe '#show' do
    let(:hit_user) { get :show, params: {id: user.id} }
    it 'assigns the @user variable' do
      hit_user
      expect(assigns(:user)).to eq(user)
    end
    it 'responds with a status of 200' do
      hit_user
      expect(response.status).to eq(200)
    end
    it 'renders the user page' do
      expect(hit_user).to render_template(:show)
    end
  end

  describe '#edit' do
    let(:hit_user) { get :edit, params: {id: user.id} }
    it 'assigns the @user variable' do
      hit_user
      expect(assigns(:user)).to eq(user)
    end
    it 'responds with a status of 200' do
      hit_user
      expect(response.status).to eq(200)
    end
    it 'renders the edit form' do
      expect(hit_user).to render_template(:edit)
    end
  end

  describe '#update' do
    let(:params) {
      {"utf8"=>"✓",
      "authenticity_token"=>"SipsF8z0O9ioN5y7E/q7qikVVB1Q5tNz1Aj1noi1DVEsFwEJ7mzf8Q5yAqvAqpz+Y9N4C1av/JNBa7dvNP6CHw==",
      "user"=>{"admin"=>"1"},
      "commit"=>"Update User",
      "id"=>user.id}
    }
    let(:hit_update) { patch :update, params: params}
    it 'updates the user in the database' do
      hit_update
      expect(user.reload.admin).to eq(true)
    end
    it 'assigns the @user variable' do
      hit_update
      expect(assigns[:user]).to eq(user)
    end
    it 'sends a flash notice' do
      hit_update
      expect(flash[:notice]).to eq('User updated')
    end
    it 'responds with a 302' do
      hit_update
      expect(response.status).to eq(302)
    end
  end
end
