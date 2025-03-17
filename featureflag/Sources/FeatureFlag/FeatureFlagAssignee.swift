import Foundation

public enum FeatureFlagAssignee: String {
    case none
    case talq
    case aUser
    case bUser
    
    /// 진행 가능 여부
    var isProceed: Bool {
        switch self {
        case .none:
            return false
            
        default:
            return true
        }
    }
}
