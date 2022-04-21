class InvitationsController < ApplicationController
  def new
    @cycle = Cycle.find(params[:cycle_id])
    @invitation = Invitation.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @cycle = Cycle.find(params[:cycle_id])
    @invitation = Invitation.new(invitation_params)
    @invitation.cycle = @cycle
    respond_to do |format|
      if @invitation.save
        format.html { redirect_to root_path, notice: 'Invitation successfully sent!' }
      else
        format.html { render :new }
      end
      format.js
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :message)
  end
end
