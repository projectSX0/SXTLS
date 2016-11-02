import PackageDescription

let package = Package(
    name: "SXTLS",
    dependencies: [.Package(url: "https://github.com/projectSX0/spartanX.git", versions: Version(0,0,0)..<Version(1,0,0)),
		.Package(url: "https://github.com/projectSX0/swiftTLS.git", versions: Version(0,0,0)..<Version(1,0,0))]
)
