import Foundation

extension Date {
    static func weekDifference(from startDate: Date, to endDate: Date) -> Int {
        let calendar = Calendar(identifier: .iso8601)
        let componentsA = calendar.dateComponents([.weekOfYear], from: startDate)
        let componentsB = calendar.dateComponents([.weekOfYear], from: endDate)
        
        guard let weekOfYearA = componentsA.weekOfYear,
              let weekOfYearB = componentsB.weekOfYear else {
            return 0
        }
        
        return weekOfYearB - weekOfYearA
    }
}
