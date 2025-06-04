
import Foundation
import UIKit
import GoogleMobileAds
import PySwiftKit
import PySerializing
import PySwiftObject
import PySwiftWrapper
import PyDictionary
//import PythonCore

var kivy_viewController: UIViewController? {
	UIApplication.shared.windows.first?.rootViewController
}

@PyModule
struct PyAdmob: PyModuleProtocol {
    static var py_classes: [any (PyClassProtocol & AnyObject).Type] = [
        BannerAd.self,
        StaticAd.self,
        FullScreenAd.self,
        GADBannerViewCallback.self,
        PyFullScreenContentDelegate.self
    ]
}

extension PySwiftModuleImport {
    public static let py_admob = PySwiftModuleImport(name: "py_admob", module: PyAdmob.py_init)
}
