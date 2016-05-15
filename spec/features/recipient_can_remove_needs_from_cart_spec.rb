require "rails_helper"

feature "Recipient can remove needs from cart" do
  scenario "needs are no longer visible in profile" do
    recipient = create(:user, role: 2)
    need1 = create(:need_type, name: "goat")
    need2 = create(:need_type, name: "soda")

    ApplicationController.any_instance.stubs(:current_user).returns(recipient)

    visit user_path(recipient)
    click_link "Add Needs"

    within("#goat") do
      click_button "Add to Basket"
    end

    within("#soda") do
      click_button "Add to Basket"
    end

    click_link "Basket: 2"

    expect(current_path).to eq "/cart"

    first(".cart-remove").click_link("Remove")

    expect(page).to have_content("Successfully removed from cart")

    expect(page).to_not have_content("goat")
    expect(page).to have_content("Basket: 1")
  end
end
