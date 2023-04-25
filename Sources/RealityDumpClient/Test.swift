import Dependencies
import Foundation
import Models

extension RealityDump {
    public static var testValue: Self {
        return Self(
            raw: { (_, _, _, _) in
                //TODO: return values for test that are more useful
                ["..."]
            },
            identify: { (_, _) in
                [.mock]
            }
        )
    }
}

extension IdentifiableEntity {
    public static var mock: Self = .init(
        id: 7_928_071_431_998_189_885,
        anchorIdentifier: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF"),
        name: "Le Mock Anchor",
        type: .anchor,
        state: .init(
            isEnabled: true,
            isEnabledInHierarchy: true,
            isActive: true,
            isAnchored: true
        ),
        hierarhy: .init(
            children: [],
            hasParent: false
        ),
        components: .init(
            componentsCount: 5
        )
    )
}
