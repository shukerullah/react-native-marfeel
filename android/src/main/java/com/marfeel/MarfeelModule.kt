package com.marfeel

import android.os.Handler
import android.os.Looper
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.module.annotations.ReactModule
import com.marfeel.compass.tracker.CompassTracking
import com.marfeel.compass.tracker.multimedia.MultimediaTracking
import com.marfeel.compass.core.model.compass.UserType
import com.marfeel.compass.core.model.multimedia.MultimediaMetadata
import com.marfeel.compass.core.model.multimedia.Type as MultimediaType
import com.marfeel.compass.core.model.multimedia.Event as MultimediaEvent

@ReactModule(name = MarfeelModule.NAME)
class MarfeelModule(reactContext: ReactApplicationContext) :
  NativeMarfeelSpec(reactContext) {

  private var tracker: CompassTracking? = null
  private var multimediaTracker: MultimediaTracking? = null
  private val mainHandler = Handler(Looper.getMainLooper())

  override fun getName(): String {
    return NAME
  }

  // Initialization
  override fun initialize(accountId: String, pageTechnology: Double?) {
    val context = reactApplicationContext
    if (pageTechnology != null) {
      CompassTracking.initialize(context, accountId, pageTechnology.toInt())
    } else {
      CompassTracking.initialize(context, accountId)
    }
    tracker = CompassTracking.getInstance()
    multimediaTracker = MultimediaTracking.getInstance()
  }

  // Page & Screen Tracking
  override fun trackNewPage(url: String, recirculationSource: String?) {
    mainHandler.post {
      tracker?.trackNewPage(url, recirculationSource)
    }
  }

  override fun trackScreen(screen: String, recirculationSource: String?) {
    mainHandler.post {
      tracker?.trackScreen(screen, recirculationSource)
    }
  }

  override fun stopTracking() {
    tracker?.stopTracking()
  }

  override fun setLandingPage(landingPage: String) {
    tracker?.setLandingPage(landingPage)
  }

  // User Identification
  override fun setSiteUserId(userId: String) {
    tracker?.setSiteUserId(userId)
  }

  override fun getUserId(): String {
    return tracker?.getUserId() ?: ""
  }

  // User Journey
  override fun setUserType(userType: String, customId: Double?) {
    val type = when (userType.lowercase()) {
      "anonymous" -> UserType.Anonymous
      "logged" -> UserType.Logged
      "paid" -> UserType.Paid
      "custom" -> {
        if (customId != null) {
          UserType.Custom(customId.toInt())
        } else {
          UserType.Anonymous
        }
      }
      else -> UserType.Anonymous
    }
    tracker?.setUserType(type)
  }

  // User RFV
  override fun getRFV(promise: Promise) {
    tracker?.getRFV { rfv ->
      promise.resolve(rfv)
    } ?: promise.reject("ERROR", "Tracker not initialized")
  }

  // Conversions
  override fun trackConversion(conversion: String) {
    tracker?.trackConversion(conversion)
  }

  // Consent
  override fun setConsent(hasConsent: Boolean) {
    tracker?.setUserConsent(hasConsent)
  }

  // Custom Dimensions - Page Vars
  override fun setPageVar(name: String, value: String) {
    tracker?.setPageVar(name, value)
  }

  // Custom Dimensions - Session Vars
  override fun setSessionVar(name: String, value: String) {
    tracker?.setSessionVar(name, value)
  }

  // Custom Dimensions - User Vars
  override fun setUserVar(name: String, value: String) {
    tracker?.setUserVar(name, value)
  }

  // User Segments
  override fun addUserSegment(segment: String) {
    tracker?.addUserSegment(segment)
  }

  override fun setUserSegments(segments: ReadableArray) {
    val segmentList = mutableListOf<String>()
    for (i in 0 until segments.size()) {
      segments.getString(i)?.let { segmentList.add(it) }
    }
    tracker?.setUserSegments(segmentList)
  }

  override fun removeUserSegment(segment: String) {
    tracker?.removeUserSegment(segment)
  }

  override fun clearUserSegments() {
    tracker?.clearUserSegments()
  }

  // Custom Metrics
  override fun setPageMetric(metric: String, value: Double) {
    tracker?.setPageMetric(metric, value.toInt())
  }

  // Multimedia Tracking
  override fun initializeMultimediaItem(
    id: String,
    provider: String,
    providerId: String,
    type: String,
    metadata: ReadableMap
  ) {
    val multimediaType = when (type.lowercase()) {
      "audio" -> MultimediaType.AUDIO
      "video" -> MultimediaType.VIDEO
      else -> MultimediaType.VIDEO
    }

    val multimediaMetadata = MultimediaMetadata(
      isLive = metadata.getBoolean("isLive"),
      title = if (metadata.hasKey("title")) metadata.getString("title") else null,
      description = if (metadata.hasKey("description")) metadata.getString("description") else null,
      url = if (metadata.hasKey("url")) metadata.getString("url") else null,
      thumbnail = if (metadata.hasKey("thumbnail")) metadata.getString("thumbnail") else null,
      authors = if (metadata.hasKey("authors")) metadata.getString("authors") else null,
      publishTime = if (metadata.hasKey("publishTime")) metadata.getDouble("publishTime").toLong() else null,
      duration = if (metadata.hasKey("duration")) metadata.getInt("duration") else null
    )

    multimediaTracker?.initializeItem(id, provider, providerId, multimediaType, multimediaMetadata)
  }

  override fun registerMultimediaEvent(id: String, event: String, eventTime: Double) {
    val multimediaEvent = when (event.lowercase()) {
      "play" -> MultimediaEvent.PLAY
      "pause" -> MultimediaEvent.PAUSE
      "end" -> MultimediaEvent.END
      "updatecurrenttime" -> MultimediaEvent.UPDATE_CURRENT_TIME
      "adplay" -> MultimediaEvent.AD_PLAY
      "mute" -> MultimediaEvent.MUTE
      "unmute" -> MultimediaEvent.UNMUTE
      "fullscreen" -> MultimediaEvent.FULL_SCREEN
      "backscreen" -> MultimediaEvent.BACK_SCREEN
      "enterviewport" -> MultimediaEvent.ENTER_VIEWPORT
      "leaveviewport" -> MultimediaEvent.LEAVE_VIEWPORT
      else -> MultimediaEvent.PLAY
    }

    multimediaTracker?.registerEvent(id, multimediaEvent, eventTime.toInt())
  }

  companion object {
    const val NAME = "Marfeel"
  }
}
