class InvitationsController < ApplicationController
  def new
    @cycle = Cycle.find(params[:cycle_id])
    @invitation = Invitation.new
  end
end
