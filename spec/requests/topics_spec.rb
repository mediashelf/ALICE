require 'spec_helper'

describe "Topics" do
  describe "GET /topics" do
    it "works! (now write some real specs)" do
      get topics_path
      response.status.should be(200)
    end
  end
  describe 'GET /topics/new' do

    context 'logged in' do
      let(:user) { Factory :user }

      before do
        post new_user_session_path, :login => user.email, :password => 'password'
        get new_topic_path
      end

      it 'displays the new topic view template' do
        response.status.should be(200)
      end
    end

    context 'not logged in' do
      before do
        get new_topic_path
      end

      it 'returns unauthorized' do
        response.status.should be(401)
      end

      it 'redirects to the login page' do
      end
    end

  end
end
