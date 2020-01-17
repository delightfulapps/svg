//
//  String+Helpers.swift
//  
//
//  Created by Matthew Delves on 15/1/20.
//

import UIKit

extension String {
  private static let formatter = NumberFormatter()

  public var cgFloat: CGFloat {
    let trimmed = trimmingCharacters(in: CharacterSet.letters)

    return CGFloat(String.formatter.number(from: trimmed)?.doubleValue ?? 0.0)
  }

  public var point: CGPoint {
    let trimmed = trimmingCharacters(in: CharacterSet.letters)
    let components = trimmed.components(separatedBy: ",")

    let x = String.formatter.number(from: components.first ?? "")?.doubleValue
    let y = String.formatter.number(from: components.last ?? "")?.doubleValue

    return CGPoint(x: x ?? 0, y: y ?? 0)
  }
}
