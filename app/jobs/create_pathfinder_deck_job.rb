class CreatePathfinderDeckJob < ActiveJob::Base
  queue_as :default

  def perform(user, xml_file)
    deck = user.pathfinder_decks.new
    s3 = Aws::S3::Resource.new(region:ENV["REGION"])
    obj = s3.bucket(ENV["AWS_BUCKET"]).object("pathfinder_decks/#{user.id}/#{xml_file.name}")
    obj.put(body: deck.compile(xml_file.attachment.read, xml_file.name))
  end
end
