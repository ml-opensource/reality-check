import SwiftUI
import RealityKit
import RealityCheckConnect

//#if os(visionOS)
struct ClockView: View {
  var body: some View {
    Model3D(named: "Wall_Kitchen_Clock_50s")
      //.rotation3DEffect(.degrees(-90), axis: .y)
  }
}

#Preview {
  ClockView()
}
//#endif

