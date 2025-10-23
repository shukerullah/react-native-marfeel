import Foundation
import MarfeelSDK_iOS

@objc(Marfeel)
class Marfeel: NSObject {

    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }

    @objc func initialize(_ accountId: String, pageTechnology: NSNumber?) {
        let accountIdInt = Int(accountId) ?? 0

        if let pageTech = pageTechnology?.intValue {
            CompassTracker.initialize(accountId: accountIdInt, pageTechnology: pageTech, endpoint: nil)
        } else {
            CompassTracker.initialize(accountId: accountIdInt, pageTechnology: nil, endpoint: nil)
        }
    }

    @objc func trackNewPage(_ url: String, recirculationSource: String?) {
        if let nsUrl = URL(string: url) {
            CompassTracker.shared.trackNewPage(url: nsUrl, rs: recirculationSource)
        }
    }

    @objc func trackScreen(_ screen: String, recirculationSource: String?) {
        CompassTracker.shared.trackScreen(screen, rs: recirculationSource)
    }
}
