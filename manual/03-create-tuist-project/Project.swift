import ProjectDescription

let orgName = "com.bonoogi"
let bundleID = "\(orgName).manual"
let name = "Manual"

let project = Project(
    name: name,
    organizationName: orgName,
    packages: [],
    settings: Settings(configurations: [
        .debug(name: "Debug", settings: [:], xcconfig: "ManualProject.xcconfig"),
        .release(name: "Release", settings: [:], xcconfig: "ManualProject.xcconfig"),
    ]),
    targets: [
        Target(
            name: name,
            platform: .iOS,
            product: .app,
            bundleId: bundleID,
            infoPlist: "\(name)/Info.plist",
            sources: ["\(name)/Sources/**"],
            resources: ["\(name)/Resources/**"],
            dependencies: [],
            settings: Settings(configurations: [
                .debug(name: "Debug", settings: [:], xcconfig: "Manual.xcconfig"),
                .release(name: "Release", settings: [:], xcconfig: "Manual.xcconfig"),
            ])
        ),
        Target(
            name: "\(name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: bundleID,
            infoPlist: "ManualTests/Info.plist",
            sources: ["ManualTests/Tests/**"],
            dependencies: [.target(name: name)]
        ),
        Target(
            name: "\(name)UITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: bundleID,
            infoPlist: "ManualUITests/Info.plist",
            sources: ["ManualUITests/Tests/**"],
            dependencies: [.target(name: name)]
        ),
    ],
    schemes: [
        Scheme(name: "Debug"),
        Scheme(name: "Release"),
    ]
)
