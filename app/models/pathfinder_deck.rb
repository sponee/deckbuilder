class PathfinderDeck < ActiveRecord::Base

  attr_accessor :cards
  attr_accessor :xml_file

  belongs_to :user

  def compile(file, name)
    @file = file
    @name = name
    Compiler.new(file).prepare_for_s3

    self.update_attributes!(document_path: "public/downloads/deck/attachment/1/#{@name}.json", name: @name)
  end
end