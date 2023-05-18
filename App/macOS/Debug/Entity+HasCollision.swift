import RealityKit

extension Entity {
    public func childrenWithCollision() -> [Entity] {
        self.children.compactMap { $0.findEntityWithCollision() }
    }

    private func findEntityWithCollision() -> Entity? {
        if let entity = self as? Entity & HasCollision {
            return entity
        }
        for child in children {
            if let found = child.findEntityWithCollision() {
                return found
            }
        }
        return nil
    }
}
