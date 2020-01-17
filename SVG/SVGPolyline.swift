//
//  SVGPolyline.swift
//  SVG
//
//  Created by Matthew Delves on 16/1/20.
//  Copyright © 2020 Delightful Apps PTY LTD. All rights reserved.
//

import SwiftUI
import SVGKit

struct SVGPolyline: View {
  let element: Node

  var body: some View {
    let strokeColor = Color(element.stroke ?? .black)
    let strokeWidth = element.strokeWidth ?? 0.0

    return SVGPolylinePath(element: element)
      .stroke(strokeColor, lineWidth: strokeWidth)
  }
}

struct SVGPolylinePath: Shape {
  let element: Node

  func path(in rect: CGRect) -> Path {
    var path = Path()

    guard let startPoint = element.points.first else { return path }

    path.move(to: startPoint)
    path.addLines(element.points)

    return path
  }
}

#if DEBUG
struct SVGPolyline_Previews: PreviewProvider {
  static var previews: some View {
//    SVGPolyline()
    Text("Placeholder content goes here")
  }
}
#endif
