import Foundation

public extension FeatureFlag {
    var targetVersion: String? {
        switch self.state {
        case let .readyForRelease(targetVersion):
            return targetVersion
            
        default:
            return nil
        }
    }
}

