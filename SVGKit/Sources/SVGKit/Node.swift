//
//  Node.swift
//
//  Created by Matthew Delves on 6/1/20.
//

import UIKit

public class Node: Equatable, Hashable {
  public enum Element: String {
    /// https://www.w3.org/TR/2011/REC-SVG11-20110816/shapes.html
    case svg
    case rect
    case group = "g"
    case path
    case polygon
    case mask
    case defs
    case circle
    case ellipse
    case line
    case polyline
  }

  public enum FillRule: String {
    case evenOdd = "evenodd"
    case nonZero = "nonzero"
  }

  public enum Attributes {
    /// https://www.w3.org/TR/2011/REC-SVG11-20110816/intro.html#TermCoreAttributes
    case width(String)
    case height(String)
    case x(String)
    case x1(String) // 1st point x coordinate
    case x2(String) // 2nd point x coordinate
    case y(String)
    case y1(String) // 1st point y coordinate
    case y2(String) // 2nd point y coordiante
    case centerX(String)
    case centerY(String)
    case radius(String) // r
    case radiusX(String) // rx
    case radiusY(String) // ry
    case fill(String)
    case fillRule(String) // fill-rule
    case stroke(String)
    case strokeWidth(String) // = "stroke-width"
    case cornerRadius(String) // rx
    case points(String) // list of points, space separated, x,y format.
    case transform(String) // translate(x y), rotate(degrees)
    case pathCommands(String) // d
    case viewBox(String)

    public var value: String {
      switch self {
      case let .width(attribute),
           let .height(attribute),
           let .x(attribute),
           let .x1(attribute),
           let .x2(attribute),
           let .y(attribute),
           let .y1(attribute),
           let .y2(attribute),
           let .fill(attribute),
           let .fillRule(attribute),
           let .strokeWidth(attribute),
           let .stroke(attribute),
           let .cornerRadius(attribute),
           let .centerX(attribute),
           let .centerY(attribute),
           let .radius(attribute),
           let .radiusX(attribute),
           let .radiusY(attribute),
           let .points(attribute),
           let .transform(attribute),
           let .pathCommands(attribute),
           let .viewBox(attribute):
        return attribute
      }
    }

    public init?(key: String, value: String, element: Node.Element) {
      switch key {
      case "width":
        self = .width(value)
      case "height":
        self = .height(value)
      case "x":
        self = .x(value)
      case "y":
        self = .y(value)
      case "cx":
        self = .centerX(value)
      case "cy":
        self = .centerY(value)
      case "r":
        self = .radius(value)
      case "rx" where element == .ellipse:
        self = .radiusX(value)
      case "ry":
        self = .radiusY(value)
      case "fill":
        self = .fill(value)
      case "fill-rule":
        self = .fillRule(value)
      case "stroke":
        self = .stroke(value)
      case "stroke-width":
        self = .strokeWidth(value)
      case "rx":
        self = .cornerRadius(value)
      case "transform":
        self = .transform(value)
      case "points":
        self = .points(value)
      case "d":
        self = .pathCommands(value)
      case "viewBox":
        self = .viewBox(value)
      case "x1":
        self = .x1(value)
      case "y1":
        self = .y1(value)
      case "x2":
        self = .x2(value)
      case "y2":
        self = .y2(value)
      default:
        return nil
      }
    }
  }

  public enum Transform: Equatable {
    case translate(x: CGFloat, y: CGFloat)
    case rotate(degrees: CGFloat)

    public static func ==(lhs: Transform, rhs: Transform) -> Bool {
      switch (lhs: lhs, rhs: rhs) {
      case let (lhs: .translate(x: lhsX, y: lhsY), rhs: .translate(x: rhsX, y: rhsY)):
        return lhsX == rhsX && lhsY == rhsY
      case let (lhs: .rotate(degrees: lhsDegrees), rhs: .rotate(degrees: rhsDegrees)):
        return lhsDegrees == rhsDegrees
      default:
        return false
      }
    }
  }

  public let element: Element
  public let parent: Node?
  public let attributes: [Attributes]
  public var children: [Node]

  private var uuid: UUID

  public static func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.uuid == rhs.uuid
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(uuid)
  }

  public init(element: Element, attributes: [String: String], parent: Node?) {
    self.uuid = UUID()
    self.element = element
    self.parent = parent

    self.attributes = attributes.reduce(into: [], { (result, attribute) in
      if let attribute = Attributes(key: attribute.key, value: attribute.value, element: element) {
        result.append(attribute)
      }
    })
    self.children = []
  }

  public var width: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.width = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var height: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.height = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var x: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.x = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var y: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.y = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var x1: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.x1 = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var y1: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.y1 = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var x2: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.x2 = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var y2: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.y2 = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var cx: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.centerX = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var cy: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.centerY = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var radius: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.radius = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var radiusX: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.radiusX = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var radiusY: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.radiusY = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var stroke: UIColor? {
    guard let attribute = attributes.first(where: {
      if case Attributes.stroke = $0 {
        return true
      }

      return false
    }) else { return parent?.stroke }

    return color(from: attribute.value)
  }

  public var strokeWidth: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.strokeWidth = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  public var fill: UIColor? {
    guard let attribute = attributes.first(where: {
      if case Attributes.fill = $0 {
        return true
      }

      return false
    }) else { return nil }

    return color(from: attribute.value)
  }

  public var cornerRadius: CGFloat? {
    guard let attribute = attributes.first(where: {
      if case Attributes.cornerRadius = $0 {
        return true
      }

      return false
    }) else { return nil }

    return attribute.value.cgFloat
  }

  static private let transformsRegex = "^(?<translate>translate\\((?<translateX>\\d+)\\s(?<translateY>\\d+)\\))?\\s?(?<rotate>rotate\\((?<rotationAngle>\\-?\\d+)\\))?"

  public var transforms: [Transform] {
    guard let transform = attributes.first(where: {
      if case Attributes.transform = $0 {
        return true
      }

      return false
    })?.value else { return [] }

    guard let regex = try? NSRegularExpression(pattern: Node.transformsRegex, options: []) else { return [] }

    guard let match = regex.firstMatch(in: transform, options: [], range: NSRange(transform.startIndex ..< transform.endIndex, in: transform)) else { return [] }

    return ["translate", "rotate"].compactMap { command in
      let commandRange = match.range(withName: command)
      guard commandRange.location != NSNotFound else { return nil }

      switch command {
      case "translate":
        /// Get the translateX and translateY
        let xRange = match.range(withName: "translateX")
        let yRange = match.range(withName: "translateY")
        guard xRange.location != NSNotFound, yRange.location != NSNotFound  else { return nil }

        let xTranslation = (transform as NSString).substring(with: xRange).cgFloat
        let yTranslation = (transform as NSString).substring(with: yRange).cgFloat

        return .translate(x: xTranslation, y: yTranslation)
      case "rotate":
        let rotateRange = match.range(withName: "rotationAngle")
        guard rotateRange.location != NSNotFound else { return nil }

        let rotateAngle = (transform as NSString).substring(with: rotateRange).cgFloat
        return .rotate(degrees: rotateAngle)
      default:
        return nil
      }
    }
  }

  public var appliedTransforms: CGAffineTransform {
    return transforms.reduce(into: CGAffineTransform.identity) { result, transform in
      switch transform {
      case let .translate(x: xTranslation, y: yTranslation):
        result = result.translatedBy(x: xTranslation, y: yTranslation)
      case let .rotate(degrees: angle):
        result = result.rotated(by: angle * CGFloat.pi / 180.0)
      }
    }
  }

  public var points: [CGPoint] {
    guard let attribute = attributes.first(where: {
      if case Attributes.points = $0 {
        return true
      }

      return false
    }) else { return [] }

    let pairs: [String] = attribute.value.components(separatedBy: " ").filter { $0.isEmpty == false }

    return pairs.map { $0.point }
  }

  public var fillRule: FillRule? {
    guard let attribute = attributes.first(where: {
      if case Attributes.fillRule = $0 {
        return true
      }

      return false
    }) else { return nil }

    return FillRule(rawValue: attribute.value)
  }

  public var pathCommands: [PathCommand] {
    guard let attribute = attributes.first(where: {
      if case Attributes.pathCommands = $0 {
        return true
      }

      return false
    }) else { return [] }

    let scanner = Scanner(string: attribute.value)
    var commands: [String] = []

    while var instruction = scanner.scanCharacters(from: .pathCommands) {
      if instruction.count == 2 {
        let first = instruction.removeFirst()
        commands.append("\(first)")
      }

      let command = scanner.scanUpToCharacters(from: .pathCommands) ?? ""
      commands.append("\(instruction)\(command)")
    }

    return commands.flatMap(PathCommand.commands(for:))
  }

  public var viewBox: CGRect? {
    guard let attribute = attributes.first(where: {
      if case Attributes.viewBox = $0 {
        return true
      }

      return false
    }) else { return parent?.viewBox }

    let boxString = attribute.value.replacingOccurrences(of: ",", with: " ")
    let scanner = Scanner(string: boxString)
    var numbers: [Double] = []

    while let number = scanner.scanDouble() {
      numbers.append(number)
    }

    guard numbers.count == 4 else { return nil }

    if (numbers[2] < 0) || (numbers[3] < 0) {
      return nil
    }

    return CGRect(x: numbers[0], y: numbers[1], width: numbers[2], height: numbers[3])
  }

  public func ratio(in size: CGSize) -> CGSize {
    let box = viewBox?.size ?? .zero
    let width = size.width / box.width
    let height = size.height / box.height

    return CGSize(width: width, height: height)
  }

  private func color(from value: String) -> UIColor? {
    if let namedColor = UIColor(named: value) {
      return namedColor
    }

    switch value.lowercased() {
    case "black": return .black
    case "darkgray": return .darkGray
    case "lightgray": return .lightGray
    case "white": return .white
    case "gray": return .gray
    case "red": return .red
    case "green": return .green
    case "blue": return .blue
    case "cyan": return .cyan
    case "yellow": return .yellow
    case "magenta": return .magenta
    case "orange": return .orange
    case "purple": return .purple
    case "brown": return .brown
    case "clear": return .clear
    case "none": return .clear
    default: break
    }

    if value.contains("#") {
      return UIColor(hex: value)
    }

    return nil
  }
}
