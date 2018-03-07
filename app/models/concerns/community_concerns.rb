# frozen_string_literal: true

module CommunityConcerns
  extend ActiveSupport::Concern

  module ClassMethods
    def create_from_geojson(filename)
      parse_geojson(filename).each do |feature|
        Community.where(name: feature.properties['name'],
                        gnis_id: feature.properties['gnis_feature_id'],
                        location: feature.geometry.as_ewkt).first_or_create
      end
    end

    def parse_geojson(filename)
      GeoRuby::SimpleFeatures::Geometry.from_geojson(File.read(filename)).features
    end
  end
end
