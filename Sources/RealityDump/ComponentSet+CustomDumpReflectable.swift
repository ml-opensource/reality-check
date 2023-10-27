import CustomDump
import RealityCodable
import RealityKit

#if os(visionOS)
extension Entity.ComponentSet: CustomDumpReflectable {
  var components: [any RealityKit.Component] {
    var components: [any RealityKit.Component] = []
    for componentType in RealityPlatform.visionOS.ComponentType.allCases.map(\.rawType) {
      if self.has(componentType) {
        components.append(self[componentType]!)
      }
    }

    return components
  }
  
    public var customDumpMirror: Mirror {
      .init(self, unlabeledChildren: components, displayStyle: .set)
//      .init(
//        self,
//        children: [
//          "components": components
//        ],
//        displayStyle: .set
//      )
      
    }

//  public var customDumpMirror: Mirror {
//    var componentsInEntity: [any RealityKit.Component] {
//      var components: [any RealityKit.Component] = []
//      for componentType in RealityPlatform.visionOS.ComponentType.allCases.map(\.rawType) {
//        if self.has(componentType) {
//          components.append(self[componentType]!)
//        }
//      }
//
//      return components
//    }
//    return .init(reflecting: componentsInEntity)
//  }
}
#endif
