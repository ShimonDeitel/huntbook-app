import Foundation

struct Outing: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var location: String
    var species: String
    var hoursOut: String
}
