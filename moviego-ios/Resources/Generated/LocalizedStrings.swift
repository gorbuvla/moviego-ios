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
    /// MovieGo
    internal static let name = L10n.tr("Localizable", "app.name")
  }

  internal enum Cinema {
    internal enum Map {
      /// Explore
      internal static let title = L10n.tr("Localizable", "cinema.map.title")
      internal enum BottomSheet {
        internal enum Button {
          /// Detail
          internal static let title = L10n.tr("Localizable", "cinema.map.bottom_sheet.button.title")
        }
      }
    }
  }

  internal enum Dashboard {
    /// Logout
    internal static let logout = L10n.tr("Localizable", "dashboard.logout")
    /// Search movies & cinemas
    internal static let searchHint = L10n.tr("Localizable", "dashboard.search_hint")
    /// In theatres
    internal static let title = L10n.tr("Localizable", "dashboard.title")
    internal enum Movie {
      /// IMDb
      internal static let imdbBadge = L10n.tr("Localizable", "dashboard.movie.imdb_badge")
      /// Tomatometer
      internal static let tomatoesBadge = L10n.tr("Localizable", "dashboard.movie.tomatoes_badge")
    }
    internal enum SessionSuggest {
      /// At %@
      internal static func subtitleCinemaFormat(_ p1: String) -> String {
        return L10n.tr("Localizable", "dashboard.session_suggest.subtitle_cinema_format", p1)
      }
      /// At %@,\n%@ away
      internal static func subtitleCinemaKmFormat(_ p1: String, _ p2: String) -> String {
        return L10n.tr("Localizable", "dashboard.session_suggest.subtitle_cinema_km_format", p1, p2)
      }
      /// Top sessions:
      internal static let title = L10n.tr("Localizable", "dashboard.session_suggest.title")
      /// %@
      internal static func titleWithYearFormat(_ p1: String) -> String {
        return L10n.tr("Localizable", "dashboard.session_suggest.title_with_year_format", p1)
      }
    }
  }

  internal enum General {
    /// Continue
    internal static let `continue` = L10n.tr("Localizable", "general.continue")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok")
  }

  internal enum Login {
    internal enum Button {
      /// Sign In
      internal static let title = L10n.tr("Localizable", "login.button.title")
    }
    internal enum Email {
      /// Email
      internal static let title = L10n.tr("Localizable", "login.email.title")
    }
    internal enum Password {
      /// Password
      internal static let title = L10n.tr("Localizable", "login.password.title")
    }
    internal enum RegisterButton {
      /// Register
      internal static let title = L10n.tr("Localizable", "login.register_button.title")
    }
  }

  internal enum Registration {
    internal enum ChooseCity {
      /// Choose your city
      internal static let title = L10n.tr("Localizable", "registration.choose_city.title")
      internal enum Unsupported {
        /// %@ is currently unsupported, ever considered moving to... Prague?:DD
        internal static func message(_ p1: String) -> String {
          return L10n.tr("Localizable", "registration.choose_city.unsupported.message", p1)
        }
        /// Unsupported city
        internal static let title = L10n.tr("Localizable", "registration.choose_city.unsupported.title")
      }
    }
    internal enum User {
      /// Set email & password
      internal static let title = L10n.tr("Localizable", "registration.user.title")
      internal enum Button {
        /// Register
        internal static let title = L10n.tr("Localizable", "registration.user.button.title")
      }
      internal enum ConfirmPassword {
        /// Confirm password
        internal static let title = L10n.tr("Localizable", "registration.user.confirm_password.title")
      }
      internal enum Email {
        /// Email
        internal static let title = L10n.tr("Localizable", "registration.user.email.title")
      }
      internal enum Name {
        /// Name
        internal static let title = L10n.tr("Localizable", "registration.user.name.title")
      }
      internal enum Password {
        /// Password
        internal static let title = L10n.tr("Localizable", "registration.user.password.title")
      }
      internal enum Surname {
        /// Surname
        internal static let title = L10n.tr("Localizable", "registration.user.surname.title")
      }
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
