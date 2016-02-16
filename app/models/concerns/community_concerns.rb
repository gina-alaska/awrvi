module CommunityConcerns
  extend ActiveSupport::Concern

  module ClassMethods
    def create_from_geojson(filename)
      parse_geojson(filename).each do |feature|
        Community.where(name: feature['name'], gnis_id: feature['gnis_feature_id'], location: feature.geometry.as_text).first_or_create
      end
    end

    def parse_geojson(filename)
      RGeo::GeoJSON.decode(File.open(filename, 'r'), json_parser: :json)
    end
  end
end
