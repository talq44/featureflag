import ProjectDescription

let project = Project(
    name: "featureflag",
    targets: [
        .target(
            name: "featureflag",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.featureflag",
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
            dependencies: []
        ),
        .target(
            name: "featureflagTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.featureflagTests",
            infoPlist: .default,
            sources: ["featureflag/Tests/**"],
            resources: [],
            dependencies: [.target(name: "featureflag")]
        ),
    ]
)
