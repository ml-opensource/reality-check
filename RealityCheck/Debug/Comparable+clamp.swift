import Foundation

@inlinable public func clamp<T: Comparable>(_ val: T, _ minimum: T, _ maximum: T) -> T {
    min(max(val, minimum), maximum)
}
