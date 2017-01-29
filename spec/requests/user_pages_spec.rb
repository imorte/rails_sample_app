require 'spec_helper'

RSpec.feature "User pages" do

  subject { page }

  shared_examples_for 'signup page' do
    it { should have_selector('h1', text: content) }
    it { should have_title(full_title(title)) }
  end

  describe "signup page" do
    before { visit signup_path }
    let(:content) { 'Sign up' }
    let(:title) { 'Sign up' }

    it_should_behave_like'signup page'
  end
end