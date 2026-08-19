// swift-tools-version:6.2
// LNPopupController:4.5.6

import PackageDescription

//Every directory under LNPopupController/Private is a header search path. These are
//listed explicitly rather than discovered with FileManager: manifests of non-root
//packages are evaluated in a sandbox, where the enumeration comes back empty and
//headers in the subdirectories silently fail to resolve.
let settings: [PackageDescription.CSetting] = [
	"",
	"/Appearance",
	"/GestureRecognizers",
	"/Minimization",
	"/Titles",
	"/TransitionAnimators",
	"/Utils",
].map { .headerSearchPath("LNPopupController/Private\($0)") }

let package = Package(
	name: "LNPopupController",
	platforms: [
		.iOS(.v13),
		.macCatalyst(.v13)
	],
	products: [
		.library(
			name: "LNPopupController",
			type: .dynamic,
			targets: ["LNPopupController", "LNPopupController-ObjC", "LNPopupController-SwiftPrivate"]),
		.library(
			name: "LNPopupController-Static",
			type: .static,
			targets: ["LNPopupController", "LNPopupController-ObjC", "LNPopupController-SwiftPrivate"]),
	],
	dependencies: [
//		.package(path: "../LNSystemMarqueeLabel"),
		.package(url: "https://github.com/LeoNatan/LNSystemMarqueeLabel", from: Version(stringLiteral: "0.1.2"))
	],
	targets: [
		.target(
			name: "LNPopupController-ObjC",
			dependencies: [
				.product(name: "LNSystemMarqueeLabel", package: "LNSystemMarqueeLabel"),
			],
			path: "LNPopupController",
			exclude: ["Info.plist", "LNPopupController.xcodeproj", "LNPopupController/Private/Swift"],
			publicHeadersPath: "include",
			cSettings: settings),
		.target(
			name: "LNPopupController-SwiftPrivate",
			dependencies: ["LNPopupController-ObjC"],
			path: "LNPopupController/LNPopupController/Private/Swift"),
		.target(
			name: "LNPopupController",
			dependencies: ["LNPopupController-ObjC"],
			path: "LNPopupController+Swift")
	],
	cxxLanguageStandard: .gnucxx20
)
