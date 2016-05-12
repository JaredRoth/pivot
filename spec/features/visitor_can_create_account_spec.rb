require "rails_helper"

feature "Visitor can create account" do
  scenario "as a donor" do
    visit signup_path

    save_and_open_page
    fill_in "First Name", with: "Jon"
    fill_in "Last Name", with: "Dadork"
    fill_in "Country", with: "Nepal"
    fill_in "E-Mail", with: "email@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    select "Donor", from: "User Type"
    click_button "Create Account"

    expect(page).to have_content("Account created!")
    expect(page).to have_content("Jon")
    expect(page).to have_content(i"Dadork")
    expect(page).to have_content("Nepal")
    expect(page).to have_content("email@email.com")
    expect(page).to_not have_link?("Login")
    expect(page).to have_link("Logout")

    click_link "Logout"

    expect(page).to have_link("Login")
  end
end

#As a visitor, who is looking to sign as a donor or recipient
#I can go to the sign up page
#Fill in required information
#Sign up as a donor or recipient
#Click Sign up for an account
#And I will see a message "Account created as donor or recipient"
#And be redirected to the rootpath
#
