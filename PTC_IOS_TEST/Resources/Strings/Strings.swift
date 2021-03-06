// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add To Cart
  internal static let addToCart = L10n.tr("Localizable", "addToCart")
  /// cart.badge.plus
  internal static let addToCartIcon = L10n.tr("Localizable", "addToCartIcon")
  /// Home
  internal static let homeVC = L10n.tr("Localizable", "homeVC")
  /// network.badge.shield.half.filled
  internal static let networkErrorIcon = L10n.tr("Localizable", "networkErrorIcon")
  /// product details
  internal static let productDetails = L10n.tr("Localizable", "productDetails")
  /// test
  internal static let test = L10n.tr("Localizable", "test")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
