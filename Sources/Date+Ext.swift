import Foundation

public extension Date {
    private static let dateFormatter = DateFormatter()

    static func getCurrentDate() -> String {
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }
}
