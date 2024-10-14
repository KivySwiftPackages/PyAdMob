
import Foundation
import UIKit
import GoogleMobileAds
import PySwiftCore
import PyEncode
import PythonCore

fileprivate var kivy_viewController: UIViewController? {
	UIApplication.shared.windows.first?.rootViewController
}

public class BannerAd {
	
	var banner: GADBannerView?
	private var scaleFactor: CGFloat = 2.0
	var height: Double
	let adUnitID: String
	
	public init(unit_id: String, height: Double) {
		self.height = height
		self.adUnitID = unit_id
	}
	
	func disable() {
		if banner != nil {
			banner?.removeFromSuperview()
			banner = nil
			//set self.ads_space in kivy back to 0
		}
		//py?.banner_did_load(w: 0, h: 0)
	}
	
	func show(delegate: GADBannerViewDelegate? = nil) {
		guard
			let kivy_vc = kivy_viewController,
			let view = kivy_vc.view
		else { return }
		scaleFactor = view.contentScaleFactor
		
		
		if banner == nil {
			let frame = view.frame
			let viewWidth = frame.width
			let scale = kivy_vc.view.contentScaleFactor
			scaleFactor = scale
			let banner = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: viewWidth / 2 , height: self.height / scale)))
			
			banner.adUnitID = adUnitID
			banner.delegate = delegate
			banner.translatesAutoresizingMaskIntoConstraints = false
			banner.rootViewController = kivy_vc
			kivy_vc.view.addSubview(banner)
			
			let horizontalConstraint = NSLayoutConstraint(item: banner, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
			let verticalConstraint = NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
			
			kivy_vc.view.addConstraints([horizontalConstraint, verticalConstraint])
			banner.load(GADRequest())
			self.banner = banner
		}
		
	}
	
}



public class StaticAd {
	
	var banner: GADBannerView?
	private var scaleFactor: CGFloat = 2.0
	var height: Double
	let adUnitID: String
	
	public init(unit_id: String, height: Double) {
		self.height = height
		adUnitID = unit_id
	}
	
	func disable() {
		if banner != nil {
			banner?.removeFromSuperview()
			banner = nil
			//set self.ads_space in kivy back to 0
		}
		//py?.banner_did_load(w: 0, h: 0)
	}
	
	func show(delegate: GADBannerViewDelegate? = nil) {
		if banner == nil {
			guard
				let kivy_vc = kivy_viewController,
				let view = kivy_vc.view
			else { return }
			scaleFactor = view.contentScaleFactor
			
			let frame = view.frame
			let viewWidth = frame.width
			let scale = kivy_vc.view.contentScaleFactor
			let banner = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: viewWidth, height: 180 / scale)))
			banner.adUnitID = adUnitID
			//enable delegate to call bannerViewDidReceiveAd function to set self.ads_space in kivy
			banner.delegate = delegate
			banner.translatesAutoresizingMaskIntoConstraints = false
			banner.rootViewController = kivy_vc
			kivy_vc.view.addSubview(banner)
			
			let horizontalConstraint = NSLayoutConstraint(item: banner, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
			let verticalConstraint = NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
			
			kivy_vc.view.addConstraints([horizontalConstraint, verticalConstraint])
			banner.load(GADRequest())
			self.banner = banner
		}
		
		
	}
}




extension PyFullScreenContentDelegate {
	func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
		adDidRecordClick(info: ad.description)
	}
	func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
		adDidRecordImpression(info: ad.description)
	}
	func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
		adDidDismissFullScreenContent(info: ad.description)
	}
	func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
		adDidDismissFullScreenContent(info: ad.description)
	}
	func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
		adWillPresentFullScreenContent(info: ad.description)
	}
	func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
		didFailToPresentFullScreenContent(info: ad.description, error: error.localizedDescription)
	}
}

public class FullScreenAd {
	
	
	var banner: GADInterstitialAd?
	let adUnitID: String
	
	public init(unit_id: String) {
		adUnitID = unit_id
	}
	
	func show(delegate: GADFullScreenContentDelegate? = nil) {
		let request = GADRequest()
		GADInterstitialAd.load(
			withAdUnitID: adUnitID,
			request: request,
			completionHandler: { [self] ad, error in
				if let error = error {
					print("Failed to load interstitial ad with error: \(error.localizedDescription)")
					return
				}
				
				ad?.fullScreenContentDelegate = delegate
				
				guard let kivy = kivy_viewController else {return}
				banner = ad
				banner?.present(fromRootViewController: kivy)
			}
		)
		
	}
}

extension PyFullScreenContentDelegate: PyEncodable {
	public var pyPointer: PyPointer { Self.asPyPointer(self) }
}

extension GADFullScreenPresentingAd {
//	var pyPointer: PyPointer { Self.asPyPointer(self) }
//	func __repr__() -> String {
//		self.debugDescription ?? "no info"
//	}
}

extension GADBannerView: PyConvertible {
	public var pyPointer: PyPointer { Self.asPyPointer(self) }
}

extension PyBannerViewDelegate: PyConvertible {
	public var pyPointer: PyPointer { Self.asPyPointer(self) }
}

