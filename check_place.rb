place = Place.last
puts "Name: #{place.name}"
puts "Current: #{place.full_address} -> #{place.latitude}, #{place.longitude}"
begin
  place.geocode
  place.save
  puts "After Geocode: #{place.latitude}, #{place.longitude}"
rescue => e
  puts "Error: #{e.message}"
end
