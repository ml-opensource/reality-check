import XCTest

@testable import RealitySymbols

final class RealitySymbolsTests: XCTestCase {
  let basePath = "/Users/cristian/Developer/external/RealitySymbols/source/reality-symbols/Sources/RealitySymbols/Extracted"

  func testIndividual() throws {
    // iOS
    let entitiesOutputPath_iOS = basePath.appending("/iOS/Processed/Entities.json")
    createEntitiesFile(from: iOSSymbolGraph, at: entitiesOutputPath_iOS)
    
    let componentsOutputPath_iOS = basePath.appending("/iOS/Processed/Components.json")
    createComponentsFile(from: iOSSymbolGraph, at: componentsOutputPath_iOS)

    // macOS
    let entitiesOutputPath_macOS = basePath.appending("/macOS/Processed/Entities.json")
    createEntitiesFile(from: macOSSymbolGraph, at: entitiesOutputPath_macOS)
    
    let componentsOutputPath_macOS = basePath.appending("/macOS/Processed/Components.json")
    createComponentsFile(from: macOSSymbolGraph, at: componentsOutputPath_macOS)

    // visionOS
    let entitiesOutputPath_visionOS = basePath.appending("/visionOS/Processed/Entities.json")
    createEntitiesFile(from: visionOSSymbolGraph, at: entitiesOutputPath_visionOS)
    
    let componentsOutputPath_visionOS = basePath.appending("/visionOS/Processed/Components.json")
    createComponentsFile(from: visionOSSymbolGraph, at: componentsOutputPath_visionOS)
  }
  
  func testUnified() {
    let entitiesOutputPath = basePath.appending("/Unified/Processed/Entities.json")
    createEntitiesFile(from: allSymbolGraphs, at: entitiesOutputPath)

    let componentsOutputPath = basePath.appending("/Unified/Processed/Components.json")
    createComponentsFile(from: allSymbolGraphs, at: componentsOutputPath)
  }
}
