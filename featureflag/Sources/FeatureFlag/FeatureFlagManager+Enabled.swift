import Foundation

extension FeatureFlagManager {
    
    public func enabled(_ featureFlag: FeatureFlag) -> Bool {
        switch featureFlag.state {
        case .unknown:
            return false
            
        case .inDevelop:
            return self.isCheckInDevelopEnable(featureFlag)
            
        case .readyForFeatureTest:
            return self.isCheckFeatureTestEnable(featureFlag)
            
        case .readyForStagingTest:
            return self.isCheckVersionTestEnable(featureFlag)
            
        case .readyForRelease:
            return self.isCheckReleaseTestEnable(featureFlag)
        }
    }
}

// - MARK: 공통
extension FeatureFlagManager {
    private func isCheckSimpleDictionaryEnable(
        dic: [String: Any],
        parentKey: String,
        ticketKey: String
    ) -> Bool {
        guard let detailDic = dic[parentKey] as? [String: Bool] else { return false }
        
        guard let issueEnable = detailDic[ticketKey] else { return false }
        
        return issueEnable
    }
    
    private func isCheckVersionCheckEnable(_ featureFlag: FeatureFlag) -> Bool {
        let appVersion = appVersion
        
        guard let targetVersion = featureFlag.targetVersion else { return false }
        
        guard let appVersionDate = self.versionDate(appVersion) else {
            return false
        }
        
        guard let targetVersionDate = self.versionDate(targetVersion) else {
            return false
        }
        
        // 날짜기반으로 버전을 적용, 앱버전과 타깃버전을 date로 비교
        let weekDifference = Date.weekDifference(
            from: targetVersionDate,
            to: appVersionDate
        )
        
        // 앱버전이, 타깃버전보다 같거나 클때 비교
        guard weekDifference >= 0 else { return false }
        
        return self.isCheckComplexityDictionaryEnable(
            dic: self.remote,
            ticketKey: featureFlag.key
        )
    }
    
    private func isCheckComplexityDictionaryEnable(
        dic: [String: Any],
        ticketKey: String
    ) -> Bool {
        // [ "IOS-1234": false ]
        // [ "IOS-1234": "false" ]
        // [ "IOS-1234": 0 ]
        if let enable = dic[ticketKey] as? Bool {
            return enable
        } else if let enable = dic[ticketKey] as? String {
            return enable.lowercased() != "false"
        } else if let enable = dic[ticketKey] as? Int {
            return enable > 0
        } else {
            // 값이 없다면, 이상이 없어서 정의되지 않았기 때문에 true로 판단
            return true
        }
    }
    
    /// 버전 체계
    /// {year - 2020}.{weekOfYear}.{count}
    /// - ex) 5.12.0 - 2025년 12주차(3월 16일 기준) 0번째
    private func versionDate(_ version: String) -> Date? {
        let versions = version.components(separatedBy: ".")
            .map { Int($0) }
            .compactMap { $0 }
        
        guard versions.count >= 3 else { return nil }
        let date = "\(Int(versions[0]) + 20).\(versions[1])".toDate("yy.ww")
        
        return date
    }
}

// - MARK: 개발 진행 중 상태
extension FeatureFlagManager {
    private func isCheckInDevelopEnable(_ featureFlag: FeatureFlag) -> Bool {
        guard featureFlag.assignee.isProceed else { return false }
        
        switch self.environment {
        case .testing:
            return self.isCheckSimpleDictionaryEnable(
                dic: LocalFlag.dic,
                parentKey: featureFlag.assignee.rawValue,
                ticketKey: featureFlag.key
            )
            
        case .staging:
            return false
            
        case .production:
            return false
        }
    }
}

// - MARK: 기능검수 대기 중(개발완료)
extension FeatureFlagManager {
    private func isCheckFeatureTestEnable(_ featureFlag: FeatureFlag) -> Bool {
        guard featureFlag.assignee.isProceed else { return false }
                
        switch self.environment {
        case .testing:
            return self.isCheckComplexityDictionaryEnable(
                dic: self.remote,
                ticketKey: featureFlag.key
            )
            
        case .staging:
            return false
            
        case .production:
            return false
        }
    }
}

// - MARK: 최종검수 대기(기능검수 완료)
extension FeatureFlagManager {
    private func isCheckVersionTestEnable(_ featureFlag: FeatureFlag) -> Bool {
        
        switch self.environment {
        case .testing:
            return self.isCheckComplexityDictionaryEnable(
                dic: self.remote,
                ticketKey: featureFlag.key
            )
            
        case .staging:
            return self.isCheckComplexityDictionaryEnable(
                dic: self.remote,
                ticketKey: featureFlag.key
            )
            
        case .production:
            return false
        }
    }
}

// - MARK: 배포 대기 중(최종검수 완료)
extension FeatureFlagManager {
    private func isCheckReleaseTestEnable(_ featureFlag: FeatureFlag) -> Bool {
        return self.isCheckVersionCheckEnable(featureFlag)
    }
}
