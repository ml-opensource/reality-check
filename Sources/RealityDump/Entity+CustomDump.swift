@_exported import CustomDump
import RealityKit

//TODO: implement subclasses of Entity
extension RealityKit.Entity: CustomDumpReflectable {
  public var customDumpMirror: Mirror {
    .init(
      self,
      children: [
        /// Identity
        "scene": self.scene?.name,
        "name": self.name,
        "id": self.id,

        /// State
        "isEnabled": self.isEnabled,
        "isEnabledInHierarchy": self.isEnabledInHierarchy,
        "isActive": self.isActive,
        "isAnchored": self.isAnchored,

        /// Hierarchy
        "parentID": self.parent?.id,
        "children": self.children.map({ $0 }),

        ///Components
        "components": self.components,

        /// Synchronization
        "synchronization": self.synchronization,
        "isOwner": self.isOwner,

        ///Nearest Anchor
        //TODO: "anchor": self.anchor,

        ///Animations
        "availableAnimations": self.availableAnimations,

        ///Animating an Entity
        //TODO: "defaultAnimationClock": self.defaultAnimationClock,
        //TODO: "bindableValues": self.bindableValues,
        //TODO: "parameters": self.parameters,

        ///Animating and Controlling Characters
        //TODO: "characterController": self.characterController,
        //TODO: "characterControllerState": self.characterControllerState,

        ///Accessibility
        "isAccessibilityElement": self.isAccessibilityElement,

          //TODO: Instance Properties
      ],
      displayStyle: .struct
    )
  }
}
