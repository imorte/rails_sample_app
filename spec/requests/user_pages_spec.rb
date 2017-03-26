require 'spec_helper'
require 'factories'

RSpec.feature "User pages" do

  subject { page }

  shared_examples_for 'signup page' do
    it { should have_selector('h1', text: content) }
    it { should have_title(full_title(title)) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:content) { user.name }
    let(:title) { user.name }

    before { visit user_path(user) }

    it_should_behave_like'signup page'
  end

  describe "signup page" do
    before { visit signup_path }
    let(:content) { 'Sign up' }
    let(:title) { 'Sign up' }
    let(:submit) { 'Create my account' }

    it_should_behave_like'signup page'

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title(full_title(title)) }
        it { should have_content('error' && 'cant\'t be blank' && 'too short') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end