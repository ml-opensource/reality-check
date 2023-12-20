import CustomDump
import Models
import RealityKit

#if os(iOS)
  extension Entity.ComponentSet: CustomDumpReflectable {
    var components: [any RealityKit.Component] {
      var components: [any RealityKit.Component] = []
      for componentType in RealityPlatform.iOS.ComponentType.allCases.map(\.rawType) {
        if self.has(componentType) {
          components.append(self[componentType]!)
        }
      }

      return components
    }

    public var customDumpMirror: Mirror {
      .init(self, unlabeledChildren: components, displayStyle: .set)
    }
  }
#elseif os(macOS)
  extension Entity.ComponentSet: CustomDumpReflectable {
    var components: [any RealityKit.Component] {
      var components: [any RealityKit.Component] = []
      for componentType in RealityPlatform.macOS.ComponentType.allCases.map(\.rawType) {
        if self.has(componentType) {
          components.append(self[componentType]!)
        }
      }

      return components
    }

    public var customDumpMirror: Mirror {
      .init(self, unlabeledChildren: components, displayStyle: .set)
    }
  }
#elseif os(visionOS)
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
    }
  }
#endif
