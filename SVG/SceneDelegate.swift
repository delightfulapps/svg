//
//  SceneDelegate.swift
//  SVG
//
//  Created by Matthew Delves on 6/1/20.
//  Copyright © 2020 Delightful Apps PTY LTD. All rights reserved.
//

import UIKit
import SwiftUI
import SVGKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = scene as? UIWindowScene else { return }
    guard let pathlineURL = Bundle.main.url(forResource: "pathline02", withExtension: "svg") else { return }
    guard let rectURL = Bundle.main.url(forResource: "rect02", withExtension: "svg") else { return }
    guard let circleURL = Bundle.main.url(forResource: "circle01", withExtension: "svg") else { return }
    guard let ellipseURL = Bundle.main.url(forResource: "ellipse01", withExtension: "svg") else { return }
    guard let lineURL = Bundle.main.url(forResource: "line01", withExtension: "svg") else { return }

    let pathParser = Parser(url: pathlineURL)
    guard let pathNode = pathParser.svg else { return }

    let rectParser = Parser(url: rectURL)
    guard let rectNode = rectParser.svg else { return }

    let circleParser = Parser(url: circleURL)
    guard let circleNode = circleParser.svg else { return }

    let ellipseParser = Parser(url: ellipseURL)
    guard let ellipseNode = ellipseParser.svg else { return }

    let lineParser = Parser(url: lineURL)
    guard let lineNode = lineParser.svg else { return }

    let multiple = List([rectNode, rectNode, rectNode, rectNode, rectNode, circleNode, ellipseNode, lineNode, pathNode], id: \.self) { svg in
      SVGView(svg: svg)
        .frame(width: 300, height: 100)
    }

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UIHostingController(rootView: multiple)
    self.window = window
    window.makeKeyAndVisible()
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }


}

