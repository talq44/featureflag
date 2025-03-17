import Foundation

public protocol FeatureFlagManager {
    /// 현재 앱 버전
    var appVersion: String { get set }
    /// 현재 (스킴) 환경
    /// - dev (개발환경) / release (실 환경)
    var environment: FeatureFlagEnvironment { get set }
    /// 피쳐플래그 외부 정의 값
    var remote: [String: Any] { get set }
}
