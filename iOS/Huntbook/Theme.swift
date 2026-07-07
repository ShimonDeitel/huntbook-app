import SwiftUI

enum Theme {
    static let background = Color(red: 0.090, green: 0.082, blue: 0.063)
    static let accent = Color(red: 0.431, green: 0.353, blue: 0.220)
    static let accent2 = Color(red: 0.541, green: 0.604, blue: 0.431)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
