class PathfinderDeck < ActiveRecord::Base

  attr_accessor :cards
  attr_accessor :xml_file

  belongs_to :user

  def compile(file, name)
    set_s3_client
    
    compiler = PathfinderDeckBuilder::Compiler.new(file)

    s3 = Aws::S3::Resource.new(region:ENV["REGION"])
    obj = s3.bucket(ENV["AWS_BUCKET"]).object(name)
    obj.put(body: JSON.pretty_generate(compiler.prepare_for_s3))

    #self.update_attributes!(contents: @content, name: @name)
  end

  def set_s3_client
    Aws.config.update({
      region: ENV["REGION"],
      credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY"], ENV["AWS_SECRET_KEY"])
    })
  end
end