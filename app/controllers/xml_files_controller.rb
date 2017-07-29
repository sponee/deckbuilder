class XmlFilesController < ApplicationController
  before_action :authenticate_user!

  def download
    @xml_file = XmlFile.find(params[:xml_file_id])
    send_data(@xml_file.attachment.read, disposition: "attachment", filename: @xml_file.name)
  end

  def index
     @xml_files = @user.xml_files
     @decks = @user.pathfinder_decks
  end
  
  def new
     @xml_file = @user.xml_files.new
  end
  
  def create
    @xml_file = @user.xml_files.new(xml_file_params)
    begin
      if @xml_file.save!
        redirect_to xml_files_path, notice: "The xml_file #{@xml_file.name} has been uploaded."
      end
    rescue => e
      flash[:error] = e.message
      redirect_to :back
    end
  end
  
  def destroy
     @xml_file = XmlFile.find(params[:xml_file_id])
     @xml_file.destroy
     redirect_to xml_files_path, notice:  "The xml_file #{@xml_file.name} has been deleted."
  end
  
  private
  
  def xml_file_params
    params.require(:xml_file).permit(:user_id, :name, :attachment)
  end
end