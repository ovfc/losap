class CollateraldutysController < ApplicationController
  cache_sweeper :report_sweeper, :only => [:create, :update, :destroy]

  respond_to :html, :xml, :js

  expose(:member)
  expose(:collateraldutys) {member.collateraldutys}
  expose(:collateralduty)

  def index
    respond_with collateraldutys
  end

  def new
    respond_with collateralduty
  end

  def create
    if collateralduty.save
      if collateralduty.points > 0
        flash[:notice] = 'Saved Collateralduty'
      else
        flash[:warning] = 'Collateralduty was saved, but is worth 0 LOSAP points'
      end
    end
    respond_with collateralduty, location: member
  end

  def update
    if collateralduty.update_attributes(params[:collateralduty])
      if collateralduty.deleted?
        flash[:notice] = 'Collateralduty Deleted'
      else
        flash[:notice] = 'Collateralduty Undeleted'
      end
    else
      flash[:warning] = 'Undeleting this Collateralduty would conflict with a Sleep-In'
    end
    respond_with collateralduty
  end

  def destroy
    collateralduty.destroy
    respond_with collateralduty, location: member
  end
end
  