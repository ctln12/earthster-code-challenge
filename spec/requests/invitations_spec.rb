require 'rails_helper'

RSpec.describe "Invitations", type: :request do
  describe 'GET /cycles/:cycle_id/invitations/new' do
    let!(:visible_cycle) { create :cycle, public_status: true }

    it "shows the form to share a cycle with a customer" do
      get new_cycle_invitation_path(visible_cycle), xhr: true

      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'new-invitation'
      expect(response.body).to include visible_cycle.name
    end
  end

  describe 'POST /cycles/:cycle_id/invitations' do
    let!(:visible_cycle) { create :cycle, public_status: true }
    # it { is_expected.to render_template(:create) }

    it "creates an invitation successfully" do
      post cycle_invitations_path(visible_cycle), params: { invitation: { email: 'john@email.com' } }, xhr: true

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq 'text/javascript'
      expect(response.body).to include 'Invitation successfully sent!'
    end

    it "renders the form with an error when :email is empty" do
      post cycle_invitations_path(visible_cycle), params: { invitation: { email: '' } }, xhr: true

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq 'text/javascript'
      expect(response.body).to include 'new-invitation'
      expect(response.body).to include 'Email can&#39;t be blank'
      expect(response.body).to include visible_cycle.name
    end
  end
end
