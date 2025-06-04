//
//  BannerAd.swift
//  PyAdmob
//
//  Created by CodeBuilder on 08/05/2025.
//
import GoogleMobileAds
import PySwiftKit
import PySerializing
import PySwiftObject
import PySwiftWrapper
import PyUnpack

@PyClass
public class BannerAd {
	
	var banner: GADBannerView?
	private var scaleFactor: CGFloat = 2.0
    @PyProperty var height: Double
    @PyProperty let adUnitID: String
	
	public init(unit_id: String, height: Double) {
		self.height = height
		self.adUnitID = unit_id
	}
	
    @PyMethod
	func disable() {
		if banner != nil {
			banner?.removeFromSuperview()
			banner = nil
			//set self.ads_space in kivy back to 0
		}
		//py?.banner_did_load(w: 0, h: 0)
	}
    @PyMethod
    func show(delegate: GADBannerViewCallback? = nil) {
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
