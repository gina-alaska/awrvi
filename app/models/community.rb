class Community < ApplicationRecord
  include CommunityConcerns
  include FriendlyId
  friendly_id :name, use: :slugged

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
    !location.blank? && geometry
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

    "© <a href='https://www.mapbox.com/about/maps/'>Mapbox</a> © <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a>".html_safe
  end
end
