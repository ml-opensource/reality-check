import Models
import XCTest
import CustomDump

@testable import RealityCheck

final class RealityCheckTests: XCTestCase {
  var encoder: JSONEncoder {
    let encoder = JSONEncoder()
    encoder.nonConformingFloatEncodingStrategy = .convertToString(
      positiveInfinity: "INF",
      negativeInfinity: "-INF",
      nan: "NAN"
    )
    encoder.outputFormatting = .prettyPrinted
    return encoder
  }

  var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.nonConformingFloatDecodingStrategy = .convertFromString(
      positiveInfinity: "INF",
      negativeInfinity: "-INF",
      nan: "NAN"
    )
    return decoder
  }

  func testSimpleDecodable() throws {
    let url = Bundle.module.url(forResource: "simple_hierarchy", withExtension: "json")!
    let data = try Data(contentsOf: url)
    let hierarchy = try! decoder.decode([IdentifiableEntity].self, from: data)
    XCTAssertNotNil(hierarchy)
    customDump(hierarchy)
  }
  
  func testNotSoSimpleDecodable() throws {
    let url = Bundle.module.url(forResource: "not_so_simple_hierarchy", withExtension: "json")!
    let data = try Data(contentsOf: url, options: .mappedIfSafe)
    let hierarchy = try! decoder.decode([IdentifiableEntity].self, from: data)
    XCTAssertNotNil(hierarchy)
    customDump(hierarchy)
  }
}
