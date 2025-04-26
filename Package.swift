// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "PyAdmob",
	platforms: [.iOS(.v13)],
	products: [
		.library(name: "PyAdmob", targets: ["PyAdmob"]),
		
	],
	dependencies: [
		.package(url: "https://github.com/KivySwiftLink/PySwiftKit", from: .init(311, 0, 0)),
		.package(url: "https://github.com/PythonSwiftLink/SwiftonizePlugin", .upToNextMajor(from: .init(0, 1, 0)) ),
		.package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", exact: .init(11, 5, 0))
	],
	targets: [

		.target(
			name: "PyAdmob",
			dependencies: [
//				"PythonLib",
				.product(name: "SwiftonizeModules", package: "PySwiftKit"),
				//.product(name: "PySwiftObject", package: "KivySwiftLink"),
				// admob package
				.product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads")
			],
			plugins: [ .plugin(name: "Swiftonize", package: "SwiftonizePlugin") ]
		),
		
	]
)
