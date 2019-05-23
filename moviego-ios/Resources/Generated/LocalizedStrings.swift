// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum App {
    /// iOS Skeleton
    internal static let name = L10n.tr("Localizable", "app.name")
  }

  internal enum Cinema {
    internal enum Detail {
      /// %@
      internal static func title(_ p1: String) -> String {
        return L10n.tr("Localizable", "cinema.detail.title", p1)
      }
    }
    internal enum Map {
      /// Cinemas
      internal static let title = L10n.tr("Localizable", "cinema.map.title")
    }
  }

  internal enum Login {
    /// Sign In
    internal static let buttonTitle = L10n.tr("Localizable", "login.button_title")
    /// Email
    internal static let emailTitle = L10n.tr("Localizable", "login.email_title")
    /// Password
    internal static let password = L10n.tr("Localizable", "login.password")
    /// Register
    internal static let registerButton = L10n.tr("Localizable", "login.register_button")
  }

  internal enum Sessions {
    /// Movie sessions
    internal static let detail = L10n.tr("Localizable", "sessions.detail")
    /// Hot sessions nearby
    internal static let title = L10n.tr("Localizable", "sessions.title")
  }

  internal enum Tabbar {
    internal enum Map {
      /// Map
      internal static let title = L10n.tr("Localizable", "tabbar.map.title")
    }
    internal enum Movies {
      /// Movies
      internal static let title = L10n.tr("Localizable", "tabbar.movies.title")
    }
    internal enum Profile {
      /// Profile
      internal static let title = L10n.tr("Localizable", "tabbar.profile.title")
    }
    internal enum Promotions {
      /// Promotions
      internal static let title = L10n.tr("Localizable", "tabbar.promotions.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
