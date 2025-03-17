import ProjectDescription

let project = Project(
    name: "featureflag",
    targets: [
        .target(
            name: "featureflag",
            destinations: .iOS,
            product: .app,
            bundleId: "com.tqtest.featureflag",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["featureflag/Sources/**"],
            resources: ["featureflag/Resources/**"],
            dependencies: [
                .external(name: "FirebaseAnalytics"),
                .external(name: "FirebaseRemoteConfig")
            ]
        ),
        .target(
            name: "featureflagTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.tqtest.featureflagTests",
            infoPlist: .default,
            sources: ["featureflag/Tests/**"],
            resources: [],
            dependencies: [.target(name: "featureflag")]
        ),
    ]
)
