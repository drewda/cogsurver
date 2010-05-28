xml.instruct!
xml.kml(:xmlns=>"http://www.opengis.net/kml/2.2") {
  xml.Document {
  @travel_fixes.each do |tf|
  xml.Placemark {
    xml.Point {
      xml.name("point no. #{tf.id}")
      xml.description("")
      xml.coordinates("#{tf.longitude},#{tf.latitude},0")
    }
  }
end
}
}