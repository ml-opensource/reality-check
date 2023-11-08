import Foundation
import SwiftUI

extension View {
  @ViewBuilder
  public func customOnChange<Value>(
    of value: Value,
    _ action: @escaping () -> Void
  ) -> some View where Value: Equatable {
    if #available(macOS 14.0, *) {
      self.onChange(of: value) { oldValue, newValue in
        // FIXME: Binary operator '==' cannot be applied to operands of type 'Value' and 'Bool'
        // if newValue == true {
        action()
        // }
      }
    } else {
      self.onChange(of: value) { newValue in
        //FIXME: Binary operator '==' cannot be applied to operands of type 'Value' and 'Bool'

        // if newValue == true {
        action()
        // }
      }
    }
  }
}
