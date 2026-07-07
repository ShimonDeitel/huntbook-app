import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 10

    @Published var items: [Outing] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("huntbook_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Outing) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: Outing) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Outing) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([Outing].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [Outing] {
        [
        Outing(date: Date().addingTimeInterval(-86400), location: "East Stand", species: "Whitetail Doe", hoursOut: "3"),
        Outing(date: Date().addingTimeInterval(-172800), location: "Ridge Blind", species: "Turkey", hoursOut: "2"),
        Outing(date: Date().addingTimeInterval(-259200), location: "South Field", species: "Whitetail Buck", hoursOut: "4")
        ]
    }
}
