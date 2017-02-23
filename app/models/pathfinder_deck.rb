class PathfinderDeck < ActiveRecord::Base

  attr_accessor :cards
  attr_accessor :xml_file

  belongs_to :user

  def compile(file)
    @file = file
    if self.is_party?(@file)
      self.compile_party(@file)
    else
      self.compile_individual(@file)
    end
  end
end