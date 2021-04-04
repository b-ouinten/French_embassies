module GeocodingHelper
  def get_address(latitude, longitude)
    center = Geocoder.search([latitude, longitude]).first
    if center
      center.address
    else
      "Address not found"
    end
  end

  def static_map(center)
    "http://maps.google.com/maps/api/staticmap?size=450x300&zoom=17&markers=#{center.latitude},#{center.longitude}&key=#{ENV["GOOGLE_MAPS_API_KEY"]}"
  end
  
  
  def street_view(center)
    "https://maps.googleapis.com/maps/api/streetview?size=450x300&location=#{center.latitude},#{center.longitude}
    &fov=80&heading=70&pitch=0&key=#{ENV["GOOGLE_MAPS_API_KEY"]}"
  end
end
