//
//  SVGEllipse.swift
//  SVG
//
//  Created by Matthew Delves on 16/1/20.
//  Copyright © 2020 Delightful Apps PTY LTD. All rights reserved.
//

import SwiftUI
import SVGKit

struct SVGEllipse: View {
  let element: Node

  var body: some View {
    let fill = Color(element.fill ?? .black)
    let strokeColor = Color(element.stroke ?? .black)
    let strokeWidth = element.strokeWidth ?? 0.0

    let position = CGPoint(
      x: element.cx ?? 0.0,
      y: element.cy ?? 0.0
    )

    return ZStack {
      Group {
        Ellipse()
          .fill(fill)
        Ellipse()
          .stroke(strokeColor, lineWidth: strokeWidth)
      }
    }
    .position(position)
    .frame(width: element.radiusX ?? 0.0, height: element.radiusY ?? 0.0)
  }
}

struct SVGEllipse_Previews: PreviewProvider {
  static var previews: some View {
    //        SVGEllipse()
    Text("Preview content goes here")
  }
}
