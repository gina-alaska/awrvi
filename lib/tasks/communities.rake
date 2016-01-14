namespace :communities do
  desc 'Import communities from geojson file.'
  task :import, [:file] => :environment do |_t, args|
    require 'rgeo/geo_json'

    filename = args[:file]
    if filename.blank?
      puts "Usage: rails \"communities:import[filename]\""
      exit 1
    end

    comm_data = File.open(filename, 'r')
    features = RGeo::GeoJSON.decode(comm_data, json_parser: :json)
    features.each do |feature|
      community = Community.new(name: feature['name'], gnis_id: feature['gnis_feature_id'], location: feature.geometry.as_text)
      community.save
    end
  end
end
