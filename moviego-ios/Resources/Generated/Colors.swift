// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#276fbf"></span>
  /// Alpha: 100% <br/> (0x276fbfff)
  internal static let bkgDark = ColorName(rgbaValue: 0x276fbfff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f6f4f3"></span>
  /// Alpha: 100% <br/> (0xf6f4f3ff)
  internal static let bkgLight = ColorName(rgbaValue: 0xf6f4f3ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f74850"></span>
  /// Alpha: 100% <br/> (0xf74850ff)
  internal static let errorRed = ColorName(rgbaValue: 0xf74850ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#183059"></span>
  /// Alpha: 100% <br/> (0x183059ff)
  internal static let primary = ColorName(rgbaValue: 0x183059ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#8db38b"></span>
  /// Alpha: 100% <br/> (0x8db38bff)
  internal static let secondary = ColorName(rgbaValue: 0x8db38bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  internal static let textDark = ColorName(rgbaValue: 0x000000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let textLight = ColorName(rgbaValue: 0xffffffff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
