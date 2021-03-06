# frozen_string_literal: true

class Community < ApplicationRecord
  include CommunityConcerns
  include FriendlyId
  friendly_id :name, use: :slugged
  paginates_per 12

  has_many :indices

  validates :name, presence: true
  validates :slug, uniqueness: true

  def to_s
    name
  end

  def latlng
    [geometry.envelope.center.lat, geometry.envelope.center.lng]
  end

  def lnglat
    [geometry.envelope.center.lng, geometry.envelope.center.lat]
  end

  def geometry
    GeoRuby::SimpleFeatures::Geometry.from_ewkt(location)
  end

  def location?
    location.present? && geometry
  end

  def static_map_url(zoom = 11, size = '300x300')
    return unless location?

    File.join(
      'https://api.mapbox.com/v4/mapbox.streets',
      "pin-s-marker+f44(#{lnglat.join(',')})",
      "#{lnglat.join(',')},#{zoom}",
      "#{size}.png"
    ) + "?access_token=#{Rails.application.secrets.mapbox_api_token}"
  end

  def static_map_attribution
    return unless location?
    # I think this is fine because it does not do any thing with user input
    # rubocop:disable Rails/OutputSafety
    "© <a href='https://www.mapbox.com/about/maps/'>Mapbox</a> © <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a>".html_safe
    # rubocop:enable Rails/OutputSafety
  end

  def google_maps_url
    "https://www.google.com/maps/@#{latlng.join(',')},13z"
  end

  def current_index
    indices.published.recent.first
  end
end
