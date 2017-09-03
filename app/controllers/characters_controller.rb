class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_s3_client, only: [:download]

  def index
    add_breadcrumb "characters", :characters_path
    @characters = @user.characters
  end

  def show
    add_breadcrumb "characters", :characters_path
    add_breadcrumb @character.name
  end

  def new
    add_breadcrumb "characters", :characters_path
    @character = @user.characters.new
  end

  def edit
    add_breadcrumb "characters", :characters_path
    add_breadcrumb @character.name, :character_path
    add_breadcrumb "edit" 
    if verified_membership
    else
      redirect_to characters_path, notice: "That isn't your character."
    end
  end

  def create
    @character = @user.characters.new(character_params)

    respond_to do |format|
      if @character.save!
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render :show, status: :created, location: @character }
      else
        format.html { render :new }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if verified_membership
      respond_to do |format|
        if @character.update(character_params)
          format.html { redirect_to @character, notice: 'Character was successfully updated.' }
          format.json { render :show, status: :ok, location: @character }
        else
          format.html { render :edit }
          format.json { render json: @character.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to characters_path, notice: "That isn't your character."
    end
  end

  def destroy
    if verified_membership
      @character.destroy
      respond_to do |format|
        format.html { redirect_to characters_url, notice: 'Character was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to characters_path, notice: "That isn't your character."
    end
  end

  def download
    @character = Character.find(params[:character_id])
    s3 = Aws::S3::Resource.new(region:ENV["REGION"])
    obj = s3.bucket(ENV["AWS_BUCKET"]).object(@character.attachment.path)
    redirect_to @character.attachment.url
  end

  private

    def verified_membership
      Character.find_by(id: params[:id], user_id: @user.id)
    end

    def set_character
      @character = Character.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :user_id, :attachment)
    end
end
