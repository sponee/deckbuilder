class PathfinderDecksController < ApplicationController

  before_action :set_deck, except: [:create, :destroy]
  before_action :set_s3_client, except: [:create, :destroy]

  def download
    s3 = Aws::S3::Resource.new(region:ENV["REGION"])
    obj = s3.bucket(ENV["AWS_BUCKET"]).object(params["name"])
    send_data(obj.get.body.read, disposition: "attachment", filename: params["name"])
    #redirect_to root_url
    #s3.bucket(ENV["AWS_BUCKET"]).object(params["name"]).get(response_target: "Desktop")
  end

  def create
    @user = User.find(current_user)
    @xml_file = @user.xml_files.find(params[:format])
    @deck = @user.pathfinder_decks.new

    @deck.compile(@xml_file.attachment.read, params[:name])
    
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

  def set_s3_client
    Aws.config.update({
      region: ENV["REGION"],
      credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY"], ENV["AWS_SECRET_KEY"])
    })
  end
end