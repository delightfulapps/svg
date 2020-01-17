//
//  SVGLine.swift
//  SVG
//
//  Created by Matthew Delves on 16/1/20.
//  Copyright © 2020 Delightful Apps PTY LTD. All rights reserved.
//

import SwiftUI
import SVGKit

struct SVGLine: View {
  let element: Node

  var body: some View {
    let strokeColor = Color(element.stroke ?? .black)
    let strokeWidth = element.strokeWidth ?? 0.0

    return SVGLinePath(element: element)
      .stroke(strokeColor, lineWidth: strokeWidth)
  }
}

struct SVGLinePath: Shape {
  let element: Node

  func path(in rect: CGRect) -> Path {
    var path = Path()

    // We need to get the start points and the end points
    let startPoint = CGPoint(
      x: element.x1 ?? 0.0,
      y: element.y1 ?? 0.0
    )

    let endPoint = CGPoint(
      x: element.x2 ?? 0.0,
      y: element.y2 ?? 0.0
    )

    path.move(to: startPoint)
    path.addLine(to: endPoint)

    return path
  }
}
