//
//  FullScreenAd.swift
//  PyAdmob
//

import GoogleMobileAds
import PySwiftKit
import PySerializing
import PySwiftObject
import PySwiftWrapper

@PyClass
class FullScreenAd {
	
	
	var banner: GADInterstitialAd?
    @PyProperty let adUnitID: String
	
    
	@PyInit init() {
        adUnitID = UUID().uuidString
	}
	
    @PyMethod
	func show(delegate: PyFullScreenContentDelegate? = nil) {
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


@PyClass
@PyContainer
final class PyFullScreenContentDelegate: NSObject {
    
    @PyCall func adDidRecordClick(info: String)
    @PyCall func adDidRecordImpression(info: String)
    @PyCall func adDidDismissFullScreenContent(info: String)
    @PyCall func adWillPresentFullScreenContent(info: String)
    @PyCall func didFailToPresentFullScreenContent(info: String, error: Error)
}

extension PyFullScreenContentDelegate: GADFullScreenContentDelegate {
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
        didFailToPresentFullScreenContent(info: ad.description, error: error)
    }
}
