import Foundation

public enum FeatureFlagState {
    /// 알수 없음
    case unknown
    /// 개발 진행 중
    case inDevelop
    /// 기능 검수 대기(기능 개발 완료)
    case readyForFeatureTest
    /// 최종 검수 대기(기능 검수 완료)
    case readyForStagingTest
    /// 실 배포 대기(최종 검수 완료)
    case readyForRelease(_ targetVersion: String)
}

extension FeatureFlagState: Equatable { }
