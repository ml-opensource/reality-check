//
//  ViewController.swift
//  UIKitStoryboard
//
//  Created by Cristian Díaz on 05.06.23.
//

import RealityCheckConnect
import RealityKit
import SwiftUI
import UIKit

class ViewController: UIViewController {

  @IBOutlet var arView: ARView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Load the "Box" scene from the "Experience" Reality File
    let boxAnchor = try! Experience.loadBox()

    // Add the box anchor to the scene
    arView.scene.anchors.append(boxAnchor)

    // Add `RealityCheckConnectView` overlay
    addRealityCheckConnect()
  }
}

extension ViewController {
  fileprivate func addRealityCheckConnect() {
    let controller = UIHostingController(rootView: RealityCheckConnectView(arView))
    addChild(controller)
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    controller.view.backgroundColor = .clear
    view.addSubview(controller.view)
    controller.didMove(toParent: self)

    NSLayoutConstraint.activate([
      controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
      controller.view.heightAnchor.constraint(equalTo: view.heightAnchor),
      controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}
