// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let local = false
let use_psk = true

let pykit_package: Package.Dependency = if local {
    .package(path: "../PySwiftKit")
} else {
    .package(url: "https://github.com/kv-swift/PySwiftKit", from: .init(311, 0, 0))
}



let package = Package(
	name: "PyAdmob",
	platforms: [.iOS(.v13)],
	products: [
		.library(name: "PyAdmob", targets: ["PyAdmob"]),
		
	],
	dependencies: [
        pykit_package,
		.package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", exact: .init(11, 5, 0))
	],
	targets: [

		.target(
			name: "PyAdmob",
			dependencies: [
				.product(name: "SwiftonizeModules", package: "PySwiftKit"),
				// admob package
				.product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
			]
		),
		
	]
)
