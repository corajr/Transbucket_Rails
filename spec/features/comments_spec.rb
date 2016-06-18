require "rails_helper"

RSpec.describe "commenting", :fake_images => true do
  let(:pin) { create(:pin, :with_surgeon_and_procedure) }
  let(:comment) { build(:comment) }
  let(:user) { create(:user, :with_confirmation) }

  before(:each) do
    login_as(user, :scope => :user)
  end

  after :each do
    Warden.test_reset!
  end

  it "creates a new comment on a pin" do
    visit "/pins/#{pin.id}"

    within("#new_comment") do
      fill_in "comment[body]", :with => comment.body
      click_button "Submit"
    end

    expect(page).to have_content(comment.body)
  end

  context "deletion" do
    let!(:comment) { create(:comment, user: user, commentable: pin) }

    before(:each) do
      visit "/pins/#{pin.id}"
      expect(page).to have_content(comment.body)
    end

    it "allows users to delete their comments (js only)", :js => true do
      accept_confirm do
        find("a.close").click
      end

      expect(page).not_to have_content(comment.body)
    end

    it "doesn't delete if confirmation is dismissed (js only)", :js => true do
      dismiss_confirm do
        find("a.close").click
      end

      expect(page).to have_content(comment.body)
    end
  end
end