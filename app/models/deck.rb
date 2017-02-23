class Deck < ActiveRecord::Base

  attr_accessor :cards
  attr_accessor :xml_file

  belongs_to :user

  def compile(file)
    Compiler.new(file).compile
  end
end