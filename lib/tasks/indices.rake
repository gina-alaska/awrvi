namespace :indices do
  desc 'Create index test data.'
  task :create, [:file] => :environment do |_t, args|
    filename = args[:file]
    if filename.blank?
      puts "Usage: rails \"indices:create[filename.yml]\""
      exit 1
    end

    index_data = File.open(filename, 'r')
    features = RGeo::GeoJSON.decode(comm_data, json_parser: :json)
    features.each do |feature|
      community = Community.new(name: feature['name'], gnis_id: feature['gnis_feature_id'], location: feature.geometry.as_text)
      community.save
    end
  end
end
