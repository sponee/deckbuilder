class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @characters = Character.all
  end

  def show
  end

  def new
    @character = @user.characters.new
  end

  def edit
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
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
        format.json { render :show, status: :ok, location: @character }
      else
        format.html { render :edit }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to characters_url, notice: 'Character was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_character
      @character = Character.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :user_id, :attachment)
    end
end
