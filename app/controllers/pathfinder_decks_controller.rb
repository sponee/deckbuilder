class PathfinderDecksController < ApplicationController

  before_action :set_deck, except: [:create, :destroy]

  def download 
    send_file(@deck.document_path) 
  end

  def create
    @user = User.find(current_user)
    @xml_file = @user.xml_files.find(params[:format])
    @deck = @user.pathfinder_decks.new

    @deck.compile(@xml_file.attachment.file.file, params[:name])
    
    if @deck.save
       redirect_to user_xml_files_path, notice: "The deck has been created."
    else
       render :new
    end
  end

  def destroy
    @user = User.find(current_user)
    @deck = PathfinderDeck.find(params[:id])
    @deck.destroy
    redirect_to user_xml_files_path, notice:  "The deck has been deleted."
  end

  private

  def set_deck
    @deck = PathfinderDeck.find(params[:pathfinder_deck_id]) 
  end 
end