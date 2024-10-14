from swift_tools.swift_types import *

"import GoogleMobileAds"


@wrapper(py_init=False)
class GADBannerView: ...

@wrapper(new=True)
class PyBannerViewDelegate(NSObject):

    def __init__(self,callback: object): ...

    @protocols("GADBannerViewDelegate")
    class Callbacks:
        
        #@func_options(no_labels={"bannerView":True})
        @no_labels(bannerView=True)
        def bannerViewDidReceiveAd(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewDidRecordClick(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewDidRecordImpression(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewDidDismissScreen(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewWillDismissScreen(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True})
        def bannerViewWillPresentScreen(self, bannerView: GADBannerView): ...

        @func_options(no_labels={"bannerView":True}, args_alias={"error": "didFailToReceiveAdWithError"})
        def bannerView(self, bannerView: GADBannerView, error: Error): ...


# @wrapper(py_init=False)
# class GADFullScreenPresentingAd:
#     def __repr__(self) -> str: ...

@wrapper(new=True)
class PyFullScreenContentDelegate(NSObject):

    def __init__(self,callback: object): ...

    

    @protocols("GADFullScreenContentDelegate")
    class Callbacks:
        
        def adDidRecordClick(self, info: str): ...

        def adDidRecordImpression(self, info: str): ...

        def adDidDismissFullScreenContent(self, info: str): ...

        def adWillDismissFullScreenContent(self, info: str): ...

        def adWillPresentFullScreenContent(self, info: str): ...

        def didFailToPresentFullScreenContent(self, info: str, error: str): ...


@wrapper
class BannerAd:

    def __init__(self, unit_id: str, height: float): ...

    #def show(self, delegate: PyBannerViewDelegate): ...

    @func_options(call_target="show")
    def _show(self): ...

    def disable(self): ...

@wrapper
class StaticAd:

    def __init__(self, unit_id: str, height: float): ...

    #def show(self, delegate: PyBannerViewDelegate): ...

    @func_options(call_target="show")
    def _show(self): ...

    def disable(self): ...

@wrapper
class FullScreenAd:

    def __init__(self, unit_id: str): ...

    #def show(self, delegate: PyFullScreenContentDelegate): ...

    @func_options(call_target="show")
    def _show(self): ...
    
    
