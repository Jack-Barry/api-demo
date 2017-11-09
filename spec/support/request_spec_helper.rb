module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

=begin
  necessary_info
  Extracts relevant key/value pairs from an array of objects

  _____Inputs_____
  body        - The array of objects that needs to be used in an equality check

  params      - An array of keys for which values should be compared to test
                equality

  object_hash - Boolean to distinguish between regular hashes and hashes of
                ActiveRecord objects. Default is false meaning the hash is
                not composed of ActiveRecord objects

  _____Output_____
  An array of objects with only the key/value pairs necessary for the given spec
=end
  def necessary_info(body, params, object_hash = false)
    body.each_with_object([]) do |item, array|
      item = object_hash ? item.attributes : item
      array << item.slice(*params)
    end
  end
end
