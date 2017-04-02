class PathfinderDeck < ActiveRecord::Base

  attr_accessor :cards
  attr_accessor :xml_file

  belongs_to :user

  def compile(file, name)
    compiler = PathfinderDeckBuilder::Compiler.new(file)

    self.update_attributes!(name: name)

    JSON.pretty_generate(compiler.prepare_for_s3)
  end
end