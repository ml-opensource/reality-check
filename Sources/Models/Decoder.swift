import Foundation

public var defaultDecoder: JSONDecoder = {
  let decoder = JSONDecoder()
  decoder.nonConformingFloatDecodingStrategy = .convertFromString(
    positiveInfinity: "INF",
    negativeInfinity: "-INF",
    nan: "NAN"
  )
  return decoder
}()
