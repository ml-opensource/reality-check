//
//  SwiftUIView.swift
//
//
//  Created by Cristian Díaz Peredo on 19.03.24.
//

import ComposableArchitecture
import SwiftUI

public struct InlineRealityCheckView: View {
  let store: StoreOf<EntitiesNavigator_visionOS>

  public init(store: StoreOf<EntitiesNavigator_visionOS>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationSplitView {
      EntitiesNavigatorView_visionOS(store: store)
        .navigationTitle("RealityCheck")
    } detail: {
      Inspector_visionOS(store: store)
    }
    .background(Color.purple.opacity(0.1).clipShape(.rect(cornerRadius: 46)))
    .tint(.purple)
  }
}
