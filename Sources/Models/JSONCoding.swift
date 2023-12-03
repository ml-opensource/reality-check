import Foundation

public var defaultEncoder: JSONEncoder = {
  let encoder = JSONEncoder()
  encoder.nonConformingFloatEncodingStrategy = .convertToString(
    positiveInfinity: "INF",
    negativeInfinity: "-INF",
    nan: "NAN"
  )
  encoder.outputFormatting = .prettyPrinted
  return encoder
}()

public var defaultDecoder: JSONDecoder = {
  let decoder = JSONDecoder()
  decoder.nonConformingFloatDecodingStrategy = .convertFromString(
    positiveInfinity: "INF",
    negativeInfinity: "-INF",
    nan: "NAN"
  )
  return decoder
}()
