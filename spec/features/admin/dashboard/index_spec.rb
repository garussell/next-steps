require 'rails_helper'

RSpec.describe "Admin Dashboard Page" do
  before(:each) do
    admin_user = User.create(username: "admin", password: "adminpassword", role: "admin", status: "approved")
    @agent1 = User.create!(username: "pal", password: "password", role: "agent", status: "pending")
    @agent2 = User.create!(username: "sal", password: "secret", role: "agent", status: "pending")
    @user1 = User.create!(username: "jil", password: "dogsname", role: "user", status: "approved")

    visit users_login_path

    fill_in "username", with: "admin"
    fill_in "password", with: "adminpassword"
    click_button "Login"

    visit admin_dashboard_index_path
  end

  describe "as an admin" do
    describe "when I visit the admin dashboard page" do

      it "I see an the header 'Admin Dashboard', 'Your Username' with name, a link to 'change password', a button to 'delete my account'" do
        expect(page).to have_current_path(admin_dashboard_index_path)
        expect(page).to have_content("Admin Dashboard")
        expect(page).to have_content("Your Username")
        expect(page).to have_link("Change password")
        expect(page).to have_button("Delete my account")
      end
      
      it "also has a section with all user accounts, a section with all pending agent accounts, and a section with approved agents, and i can see the username and status of the agent accounts" do
        expect(page).to have_content("User Accounts")
        expect(page).to have_content("Approved Agents")
        expect(page).to have_content("Pending Agents")
        expect(page).to have_content("Rejected Agents")
    
        within('div.user-accounts') do
          expect(page).to have_content("Username: jil")
          expect(page).to have_content("Status: approved")
        end
      end
      
      it "I also see a section for pending agents and aproved agents, and in the pending section i see a button to approve and a button to reject agent" do

        within('div.pending-agents') do
          expect(page).to have_content("Username: ")
          expect(page).to have_content("Status: ")
          expect(page).to have_button("Approve Agent").twice
          expect(page).to have_button("Reject Agent").twice
        end
      end

      it "when i click on 'Approve Agent' the agent moves to the Approved section and I see a success message, and a button appears to reject that agent" do
    
        within('div.pending-agents') do
          expect(page).to have_content(@agent1.username)
          click_button("Approve Agent", match: :first)
          expect(page).to_not have_content(@agent1.username)
        end

        expect(page).to have_content("Agent has been approved")

        within('div.approved-agents') do
          expect(page).to have_content(@agent1.username)
          expect(page).to have_button("Reject Agent")
        end
      end

      it "when I click on 'Reject Agent' the agent moves to the rejected section and I see a success message, and a button appears to approve that agent" do

        within('div.pending-agents') do
          expect(page).to have_content(@agent1.username)
          click_button("Reject Agent", match: :first)
          expect(page).to_not have_content(@agent1.username)
        end

        expect(page).to have_content("Agent has been rejected")

        within('div.rejected-agents') do
          expect(page).to have_content(@agent1.username)
          expect(page).to have_button("Approve Agent")
        end
      end

      it "if there are no pending agents I see text that says 'No pending agents found'" do
        within('div.pending-agents') do
          click_button("Approve Agent", match: :first)
          click_button("Approve Agent", match: :first)
          expect(page).to have_content("No pending agents found.")
        end
      end

      it "if there are no approved agents I see text that says 'No approved agents found'" do
        within('div.approved-agents') do
          expect(page).to have_content("No approved agents found.")
        end
      end

      it "if there are no rejected agents I see text that says 'No rejected agents found'" do
        within('div.rejected-agents') do
          expect(page).to have_content("No rejected agents found.")
        end
      end
    end
  end
end