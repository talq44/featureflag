import Foundation

extension String {
    func toDate(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        return date
    }
}
