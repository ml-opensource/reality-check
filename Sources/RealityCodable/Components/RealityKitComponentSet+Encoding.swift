import Foundation
import Models
import RealityKit

extension RealityKit.Entity.ComponentSet {

  #if os(iOS)

    public var encoded: [RealityPlatform.iOS.Component] {
      //FIXME: this will be more correct using `Set`
      var encodedComponents: [RealityPlatform.iOS.Component] = []

      for componentType in RealityPlatform.iOS.ComponentType.allCases {
        if let component = self[componentType.rawType] {
          let encodedComponent = componentType.makeCodable(from: component)
          encodedComponents.append(encodedComponent)
        }
      }

      return encodedComponents
    }

  #elseif os(macOS)

    public var encoded: [RealityPlatform.macOS.Component] {
      //FIXME: this will be more correct using `Set`
      var encodedComponents: [RealityPlatform.macOS.Component] = []

      for componentType in RealityPlatform.macOS.ComponentType.allCases {
        if let component = self[componentType.rawType] {
          let encodedComponent = componentType.makeCodable(from: component)
          encodedComponents.append(encodedComponent)
        }
      }

      return encodedComponents
    }

  #elseif os(visionOS)

    public var encoded: [RealityPlatform.visionOS.Component] {
      //FIXME: this will be more correct using `Set`
      var encodedComponents: [RealityPlatform.visionOS.Component] = []

      for componentType in RealityPlatform.visionOS.ComponentType.allCases {
        if let component = self[componentType.rawType] {
          let encodedComponent = componentType.makeCodable(from: component)
          encodedComponents.append(encodedComponent)
        }
      }

      return encodedComponents
    }

  #endif

}
