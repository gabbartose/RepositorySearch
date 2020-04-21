import Foundation

extension Date {
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.DD.YYYY"
        return dateFormatter.string(from: self)
    }
}