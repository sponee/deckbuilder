class CampaignNotesController < ApplicationController
  before_action :authenticate_user!

  def show
    @campaign_note = CampaignNote.find(params[:id])
  end

  def index
    @campaign_notes = CampaignNote.where(campaign_id: params[:campaign_id])
  end

  def new
    @campagin_note = @user.campaign_notes.new
  end

  def create
    @campaign_note = CampaignNote.new(campaign_note_params)
    if @campaign_note.save!
      redirect_to campaign_campaign_note_path(campaign_id: params[:campaign_id], id: @campaign_note.id)
    else 
      render "new"
    end
  end

  def update
    @campaign_note = CampaignNote.find(params[:id])
    if @campaign_note.update!(campaign_note_params) && verified_ownership
      redirect_to campaign_campaign_note_path(campaign_id: @campaign_note.campaign_id, id: @campaign_note.id), notice: "Your note has been updated."
    end
  end

  def edit
    @campaign_note = CampaignNote.find(params[:id])
    if verified_ownership
    else
      redirect_to campaign_campaign_note_path(campaign_id:@campaign_note.id, id: @campaign_note.id), notice: "Those aren't your notes."
    end
  end

  def destroy
  end

  private

  def verified_ownership
    CampaignNote.find_by(id: params[:id], user_id: @user.id)
  end

  def campaign_note_params
    params.require(:campaign_note).permit(:name, :description, :content, :user_id, :campaign_id, :session_date)
  end
end
