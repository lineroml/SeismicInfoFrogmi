require 'net/http'
require 'json'

namespace :seismic_data do
  desc 'Fetch and persist seismic data from USGS feed'

  task fetch: [:environment] do
    puts "Executing rake task: seismic_data:fetch"
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    # first_feature = data['features'][0]
    # pretty_output = JSON.pretty_generate(first_feature)
    # puts pretty_output


    # Extract and validate data
    data['features'].each do |feature|
      id = feature['id']
      mag = feature['properties']['mag']
      place = feature['properties']['place']
      time = feature['properties']['time']
      tsunami = feature['properties']['tsunami'] == 1 # Convert to boolean
      magType = feature['properties']['magType']
      title = feature['properties']['title']
      longitude = feature['geometry']['coordinates'][0]
      latitude = feature['geometry']['coordinates'][1]
      externalUrl = feature['properties']['url']

      # Los valores de `title`, `url`, `place`, `magType` y coordinates no pueden ser nulos. En caso contrario no persistir.
      # Validar rangos para magnitude [-1.0, 10.0], latitude [-90.0, 90.0] y longitude: [-180.0, 180.0]
      # No deben duplicarse registros si se lanza la task más de una vez.

      next if id == nil || mag == nil || place == nil || magType == nil || title == nil || longitude == nil || latitude == nil || externalUrl == nil
      next if mag < -1.0 || mag > 10.0
      next if latitude < -90.0 || latitude > 90.0
      next if longitude < -180.0 || longitude > 180.0
      # Add more validation for other fields if needed
      # check if the record already exists
      next if Feature.exists?(external_id: id)

      # Save valid data to database
      Feature.create(
        external_id: id,
        magnitude: mag,
        place: place,
        time: time,
        tsunami: tsunami,
        mag_type: magType,
        title: title,
        created_at: Time.now,
        longitude: longitude,
        latitude: latitude,
        external_url: externalUrl
      )

      puts "Record created for #{id}"
    end
  end
end
