import CustomDump
import Models
import XCTest

@testable import RealityCheck

final class RealityCheckTests: XCTestCase {
  func testSimpleDecodable() throws {
    let url = Bundle.module.url(forResource: "simple_hierarchy", withExtension: "json")!
    let data = try Data(contentsOf: url)
    let hierarchy = try! defaultDecoder.decode(CodableARView.self, from: data)
    //Re - Encode
    let hierarchyData = try! defaultEncoder.encode(hierarchy)
    let hierarchyReDecoded = try! defaultDecoder.decode(CodableARView.self, from: hierarchyData)

    XCTAssertFalse(hierarchyReDecoded.scene.anchors.isEmpty)
    customDump(hierarchyReDecoded)
  }

  //  func testNotSoSimpleDecodable() throws {
  //    let url = Bundle.module.url(forResource: "not_so_simple_hierarchy", withExtension: "json")!
  //    let data = try Data(contentsOf: url)
  //    let hierarchy = try! decoder.decode([CodableEntity].self, from: data)
  //    XCTAssertNotNil(hierarchy)
  //    customDump(hierarchy)
  //  }

  func testARViewDecodable() throws {
    let url = Bundle.module.url(forResource: "codable_arview", withExtension: "json")!
    let data = try Data(contentsOf: url, options: .mappedIfSafe)
    let hierarchy = try! defaultDecoder.decode(CodableARView.self, from: data)
    XCTAssertNotNil(hierarchy)
    customDump(hierarchy)
  }
}
