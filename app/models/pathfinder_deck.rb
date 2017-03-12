class PathfinderDeck < ActiveRecord::Base

  attr_accessor :cards
  attr_accessor :xml_file

  belongs_to :user

  def compile(file, name)
    @file = file
    @name = name
    @content = PathfinderDeckBuilder::Compiler.new(file).prepare_for_s3

    self.update_attributes!(contents: @content, name: @name)
  end
end