import Foundation

public struct FeatureFlag {
    let key: String
    let description: String
    let state: FeatureFlagState
    let assignee: FeatureFlagAssignee
}


