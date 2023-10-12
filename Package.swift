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
		.package(url: "https://github.com/PythonSwiftLink/KivySwiftLink", from: .init(310, 0, 0)),
		.package(url: "https://github.com/PythonSwiftLink/SwiftonizePlugin", from: .init(0, 0, 0)),
		.package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", branch: "main")
	],
	targets: [

		.target(
			name: "PyAdmob",
			dependencies: [
//				"PythonLib",
				.product(name: "PythonSwiftCore", package: "KivySwiftLink"),
				.product(name: "PySwiftObject", package: "KivySwiftLink"),
				// admob package
				.product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads")
			],
			plugins: [ .plugin(name: "Swiftonize", package: "SwiftonizePlugin") ]
		),
		
	]
)
