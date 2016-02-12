module CommunityConcerns
  extend ActiveSupport::Concern

  module ClassMethods
    def read_communities
      Dir.glob(Rails.root.join("db", "seeds", "communities", "*.geojson")).each do |filename|
        puts "Loading commuities from #{filename}"

        comm_data = File.open(filename, 'r')
        features = RGeo::GeoJSON.decode(comm_data, json_parser: :json)

        features.each do |feature|
          Community.where(name: feature['name'], gnis_id: feature['gnis_feature_id'], location: feature.geometry.as_text).first_or_create
        end
      end
    end
  end
end
