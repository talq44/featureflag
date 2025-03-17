import Foundation

public extension FeatureFlag {
    static let IOS_123 = FeatureFlag(
        key: "IOS-123",
        description: "최초 정의를 확인합니다.",
        state: .inDevelop,
        assignee: .talq
    )
}
