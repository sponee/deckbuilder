class PathfinderDecksController < ApplicationController
  before_action :authenticate_user!

  before_action :set_deck, except: [:destroy]
  before_action :set_s3_client, except: [:destroy]

  def download
    s3 = Aws::S3::Resource.new(region:ENV["REGION"])
    obj = s3.bucket(ENV["AWS_BUCKET"]).object("pathfinder_decks/#{params[:user_id]}/#{params[:name]}")
    send_data(obj.get.body.read, disposition: "attachment", filename: params["name"])
  end

  def destroy
    @deck = PathfinderDeck.find(params[:id])
    @deck.destroy
    redirect_to xml_files_path, notice:  "The deck has been deleted."
  end

  private

  def set_deck
    @deck = PathfinderDeck.find(params[:pathfinder_deck_id]) 
  end

  def set_s3_client
    Aws.config.update({
      region: ENV["REGION"],
      credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY"], ENV["AWS_SECRET_KEY"])
    })
  end
end