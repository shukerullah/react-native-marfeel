import Foundation
import CompassSDK

@objc(MarfeelBridge)
class MarfeelBridge: NSObject {

    // Initialization
    @objc static func initializeTracker(accountId: Int, pageTechnology: NSNumber?) {
        if let pageTech = pageTechnology {
            CompassTracker.initialize(accountId: accountId, pageTechnology: pageTech.intValue, endpoint: nil)
        } else {
            CompassTracker.initialize(accountId: accountId, pageTechnology: nil, endpoint: nil)
        }
    }

    // Page & Screen Tracking
    @objc static func trackNewPage(url: URL, recirculationSource: String?) {
        CompassTracker.shared.trackNewPage(url: url, rs: recirculationSource)
    }

    @objc static func trackScreen(name: String, recirculationSource: String?) {
        CompassTracker.shared.trackScreen(name: name, rs: recirculationSource)
    }

    @objc static func stopTracking() {
        CompassTracker.shared.stopTracking()
    }

    @objc static func setLandingPage(landingPage: URL) {
        CompassTracker.shared.setLandingPage(landingPage: landingPage)
    }

    // User Identification
    @objc static func setSiteUserId(userId: String) {
        CompassTracker.shared.setSiteUserId(userId: userId)
    }

    @objc static func getUserId() -> String {
        return CompassTracker.shared.getUserId()
    }

    // User Journey
    @objc static func setUserType(userType: String, customId: NSNumber?) {
        let type: UserType
        switch userType.lowercased() {
        case "anonymous":
            type = .anonymous
        case "logged":
            type = .logged
        case "paid":
            type = .paid
        case "custom":
            if let customIdValue = customId {
                type = .custom(customIdValue.intValue)
            } else {
                type = .anonymous
            }
        default:
            type = .anonymous
        }
        CompassTracker.shared.setUserType(type)
    }

    // User RFV
    @objc static func getRFV(completion: @escaping (String) -> Void) {
        CompassTracker.shared.getRFV { rfv in
            completion(rfv)
        }
    }

    // Conversions
    @objc static func trackConversion(conversion: String) {
        CompassTracker.shared.trackConversion(conversion: conversion)
    }

    // Consent
    @objc static func setConsent(value: Bool) {
        CompassTracker.shared.setConsent(value: value)
    }

    // Custom Dimensions - Page Vars
    @objc static func setPageVar(name: String, value: String) {
        CompassTracker.shared.setPageVar(name: name, value: value)
    }

    // Custom Dimensions - Session Vars
    @objc static func setSessionVar(name: String, value: String) {
        CompassTracker.shared.setSessionVar(name: name, value: value)
    }

    // Custom Dimensions - User Vars
    @objc static func setUserVar(name: String, value: String) {
        CompassTracker.shared.setUserVar(name: name, value: value)
    }

    // User Segments
    @objc static func addUserSegment(segment: String) {
        CompassTracker.shared.addUserSegment(segment: segment)
    }

    @objc static func setUserSegments(segments: [String]) {
        CompassTracker.shared.setUserSegments(segments: segments)
    }

    @objc static func removeUserSegment(segment: String) {
        CompassTracker.shared.removeUserSegment(segment: segment)
    }

    @objc static func clearUserSegments() {
        CompassTracker.shared.clearUserSegments()
    }

    // Custom Metrics
    @objc static func setPageMetric(name: String, value: Int) {
        CompassTracker.shared.setPageMetric(name: name, value: value)
    }

    // Multimedia Tracking
    @objc static func initializeMultimediaItem(
        id: String,
        provider: String,
        providerId: String,
        type: String,
        metadata: [String: Any]
    ) {
        let mediaType: MediaType = type.lowercased() == "audio" ? .AUDIO : .VIDEO

        var multimediaMetadata = MultimediaMetadata()

        if let isLive = metadata["isLive"] as? Bool {
            multimediaMetadata.isLive = isLive
        }
        if let title = metadata["title"] as? String {
            multimediaMetadata.title = title
        }
        if let description = metadata["description"] as? String {
            multimediaMetadata.description = description
        }
        if let urlString = metadata["url"] as? String, let url = URL(string: urlString) {
            multimediaMetadata.url = url
        }
        if let thumbnail = metadata["thumbnail"] as? String {
            multimediaMetadata.thumbnail = thumbnail
        }
        if let authors = metadata["authors"] as? String {
            multimediaMetadata.authors = authors
        }
        if let publishTime = metadata["publishTime"] as? Int64 {
            multimediaMetadata.publishTime = publishTime
        }
        if let duration = metadata["duration"] as? Int {
            multimediaMetadata.duration = duration
        }

        CompassTrackerMultimedia.shared.initializeItem(
            id: id,
            provider: provider,
            providerId: providerId,
            type: mediaType,
            metadata: multimediaMetadata
        )
    }

    @objc static func registerMultimediaEvent(id: String, event: String, eventTime: Int) {
        let mediaEvent: MediaEvent
        switch event.lowercased() {
        case "play": mediaEvent = .PLAY
        case "pause": mediaEvent = .PAUSE
        case "end": mediaEvent = .END
        case "updatecurrenttime": mediaEvent = .UPDATE_CURRENT_TIME
        case "adplay": mediaEvent = .AD_PLAY
        case "mute": mediaEvent = .MUTE
        case "unmute": mediaEvent = .UNMUTE
        case "fullscreen": mediaEvent = .FULL_SCREEN
        case "backscreen": mediaEvent = .BACK_SCREEN
        case "enterviewport": mediaEvent = .ENTER_VIEWPORT
        case "leaveviewport": mediaEvent = .LEAVE_VIEWPORT
        default: mediaEvent = .PLAY
        }

        CompassTrackerMultimedia.shared.registerEvent(id: id, event: mediaEvent, eventTime: eventTime)
    }
}
