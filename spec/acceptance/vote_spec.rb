require File.dirname(__FILE__) + '/acceptance_helper'

feature "Vote", %q{
  In order to express my opinion
  As an user
  I want to vote positively or negatively on a proposal
} do

  let(:proposal) { Factory(:proposal) }
  let(:event) { proposal.event }

  scenario "While not logged in, I should not be able to like a proposal" do
    visit event_page(event)

    click_link "+"

    page.should have_content("Sign in")
    page.should have_no_content('You liked the proposal.')
  end

  scenario "While not logged in, I should not be able to dislike a proposal" do
    visit event_page(event)

    click_link "-"
    page.should have_content("Sign in")
    page.should have_no_content('You disliked the proposal.')
  end

  scenario "While logged in, I should be able to like a proposal" do
    sign_in

    visit event_page(event)

    click_link "+"
    page.should have_no_content("Sign in")
    page.should have_content('You liked the proposal.')
  end

  scenario "While logged in, I should be able to dislike a proposal" do
    sign_in

    visit event_page(event)

    click_link "-"
    page.should have_no_content("Sign in")
    page.should have_content('You disliked the proposal.')
  end
end
