import Foundation

public enum FeatureFlagEnvironment {
    /// 기능검수를 위한 환경(dev)
    case testing
    /// 최종검수를 위한 환경(QA -> staging)
    case staging
    /// 실 배포를 위한 환경(production or release)
    case production
    
    /// env string을 lowercased해 초기화
    /// - testing: "testing" or "dev" 를 포함하고 있을 경우
    /// - staging: "staging" or "qa" 를 포함하고 있을 경우
    /// - production : "production" 을 포함하는 경우
    /// - 예외일경우, testing을 반환합니다.
    public init(enviromentString: String) {
        let env_lower = enviromentString.lowercased()
        
        switch env_lower {
        case let str where str.contains("dev") || str.contains("testing"):
            self = .testing
            
        case let str where str.contains("qa") || str.contains("staging"):
            self = .staging
            
        case let str where str.contains("production"):
            self = .production
            
        default:
            self = .testing
        }
    }
}
