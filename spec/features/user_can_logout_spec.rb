require "rails_helper"

feature "User can logout " do
  scenario "successfully" do
    user = create(:user)

    sign_in(user)

    expect(page).to have_content("Logged in as #{user.first_name}")

    click_link "Logout"

    expect(page).to_not have_content("Logged in as #{user.first_name}")

    within("li:nth-child(4)") do
      expect(page).to have_content("Login or Create Account")
    end
  end
end