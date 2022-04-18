class InvitationsController < ApplicationController
  def new
    @cycle = Cycle.find(params[:cycle_id])
    @invitation = Invitation.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @cycle = Cycle.find(params[:cycle_id])
    @invitation = Invitation.new(invitation_params)
    @invitation.cycle = @cycle
    @invitation.save

    respond_to do |format|
      format.js
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :message)
  end
end
