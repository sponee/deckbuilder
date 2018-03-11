class CampaignNotesController < ApplicationController
  before_action :authenticate_user!

  def show
    @campaign_note = CampaignNote.find(params[:id])
    add_breadcrumb @campaign_note.campaign.name, campaign_path(@campaign_note.campaign.id)
  end

  def index
    @campaign_notes = CampaignNote.where(campaign_id: params[:campaign_id])
    campaign = Campaign.find(params[:campaign_id])
    add_breadcrumb campaign.name, campaign_path(campaign.id)
    add_breadcrumb "notes", campaign_campaign_notes_path(campaign.id)
  end

  def new
    @campagin_note = @user.campaign_notes.new
    campaign = Campaign.find(params[:campaign_id])
    add_breadcrumb campaign.name, campaign_path(campaign.id)
    add_breadcrumb "notes", campaign_campaign_notes_path(campaign.id)
  end

  def create
    @campaign_note = CampaignNote.new(campaign_note_params)
    begin
      if @campaign_note.save!
        redirect_to campaign_campaign_note_path(campaign_id: params[:campaign_id], id: @campaign_note.id), notice: "Your note has been created."
      end
    rescue => e
      flash[:error] = e.message
      redirect_back(fallback_location: root_url, notice: e.message)
    end
  end

  def update
    @campaign_note = CampaignNote.find(params[:id])
    begin
      if @campaign_note.update!(campaign_note_params) && verified_ownership
        redirect_to campaign_campaign_note_path(campaign_id: @campaign_note.campaign_id, id: @campaign_note.id), notice: "Your note has been updated."
      end
    rescue => e
      redirect_back(fallback_location: root_url, notice: e.message)
    end
  end

  def edit
    @campaign_note = CampaignNote.find(params[:id])
    campaign = Campaign.find(@campaign_note.campaign_id)
    add_breadcrumb campaign.name, campaign_path(campaign.id)
    add_breadcrumb "notes", campaign_campaign_notes_path(campaign.id)
    if verified_ownership
    else
      redirect_to campaign_campaign_note_path(campaign_id:@campaign_note.id, id: @campaign_note.id), notice: "Those aren't your notes."
    end
  end

  def destroy
    @campaign_note = CampaignNote.find(params[:id])
    campaign_id = @campaign_note.campaign_id
    if verified_ownership && @campaign_note.destroy
      redirect_to campaign_path(campaign_id), notice: "Your note has been destroyed."
    else
      redirect_back(fallback_location: root_url, notice: "That is not your note")
    end
  end

  private

  def verified_ownership
    CampaignNote.find_by(id: params[:id], user_id: @user.id)
  end

  def campaign_note_params
    params.require(:campaign_note).permit(:name, :description, :content, :user_id, :campaign_id, :session_date)
  end
end
