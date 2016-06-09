class XmlFilesController < ApplicationController
   before_action :authenticate_user!

   def index
      @user = current_user
      @xml_files = @user.xml_files
      @decks = @user.decks
   end
   
   def new
      @user = User.find(current_user)
      @xml_file = @user.xml_files.new
   end
   
   def create
      @user = User.find(current_user)
      @xml_file = @user.xml_files.new(xml_file_params)
      
      if @xml_file.save
         redirect_to user_xml_files_path, notice: "The xml_file #{@xml_file.name} has been uploaded."
      else
         render "new"
      end
   end
   
   def destroy
      @user = User.find(current_user)
      @xml_file = XmlFile.find(params[:id])
      @xml_file.destroy
      redirect_to user_xml_files_path, notice:  "The xml_file #{@xml_file.name} has been deleted."
   end
   
   private
      def xml_file_params
      params.require(:xml_file).permit(:user_id, :name, :attachment)
   end
   
end