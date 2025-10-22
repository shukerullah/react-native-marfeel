import NativeMarfeel from './NativeMarfeel';

// Types
export type UserType = 'anonymous' | 'logged' | 'paid' | 'custom';

export type MultimediaType = 'audio' | 'video';

export type MultimediaEvent =
  | 'play'
  | 'pause'
  | 'end'
  | 'updateCurrentTime'
  | 'adPlay'
  | 'mute'
  | 'unmute'
  | 'fullscreen'
  | 'backscreen'
  | 'enterViewport'
  | 'leaveViewport';

export interface MultimediaMetadata {
  isLive?: boolean;
  title?: string;
  description?: string;
  url?: string;
  thumbnail?: string;
  authors?: string;
  publishTime?: number;
  duration?: number;
}

// Main Marfeel SDK API
export class Marfeel {
  /**
   * Initialize the Marfeel SDK with your account ID
   * @param accountId Your Marfeel account ID
   * @param pageTechnology Optional page technology ID (default is 4 for Android App)
   */
  static initialize(accountId: string, pageTechnology?: number): void {
    NativeMarfeel.initialize(accountId, pageTechnology);
  }

  /**
   * Track a new page view
   * @param url The canonical URL of the page
   * @param recirculationSource Optional recirculation source
   */
  static trackNewPage(url: string, recirculationSource?: string): void {
    NativeMarfeel.trackNewPage(url, recirculationSource);
  }

  /**
   * Track a screen (for views without a real URI)
   * @param screen The screen name
   * @param recirculationSource Optional recirculation source
   */
  static trackScreen(screen: string, recirculationSource?: string): void {
    NativeMarfeel.trackScreen(screen, recirculationSource);
  }

  /**
   * Stop tracking the current page/screen
   */
  static stopTracking(): void {
    NativeMarfeel.stopTracking();
  }

  /**
   * Set the landing page of the current session
   * @param landingPage The landing page URL
   */
  static setLandingPage(landingPage: string): void {
    NativeMarfeel.setLandingPage(landingPage);
  }

  /**
   * Set a custom user ID
   * @param userId The user ID
   */
  static setSiteUserId(userId: string): void {
    NativeMarfeel.setSiteUserId(userId);
  }

  /**
   * Get the Marfeel-generated user ID
   * @returns The Marfeel user ID
   */
  static getUserId(): string {
    return NativeMarfeel.getUserId();
  }

  /**
   * Set the user type for user journey tracking
   * @param userType The type of user (anonymous, logged, paid, custom)
   * @param customId Optional custom ID (required if userType is 'custom')
   */
  static setUserType(userType: UserType, customId?: number): void {
    NativeMarfeel.setUserType(userType, customId);
  }

  /**
   * Get the RFV (Recency, Frequency, Value) of the user
   * @returns Promise that resolves with the RFV value
   */
  static async getRFV(): Promise<string> {
    return NativeMarfeel.getRFV();
  }

  /**
   * Track a conversion event
   * @param conversion The conversion name
   */
  static trackConversion(conversion: string): void {
    NativeMarfeel.trackConversion(conversion);
  }

  /**
   * Set user consent for data tracking
   * @param hasConsent Whether the user has given consent
   */
  static setConsent(hasConsent: boolean): void {
    NativeMarfeel.setConsent(hasConsent);
  }

  /**
   * Set a page-level custom variable
   * @param name The variable name
   * @param value The variable value
   */
  static setPageVar(name: string, value: string): void {
    NativeMarfeel.setPageVar(name, value);
  }

  /**
   * Set a session-level custom variable
   * @param name The variable name
   * @param value The variable value
   */
  static setSessionVar(name: string, value: string): void {
    NativeMarfeel.setSessionVar(name, value);
  }

  /**
   * Set a user-level custom variable
   * @param name The variable name
   * @param value The variable value
   */
  static setUserVar(name: string, value: string): void {
    NativeMarfeel.setUserVar(name, value);
  }

  /**
   * Add a user segment
   * @param segment The segment name
   */
  static addUserSegment(segment: string): void {
    NativeMarfeel.addUserSegment(segment);
  }

  /**
   * Replace all user segments with a new set
   * @param segments Array of segment names
   */
  static setUserSegments(segments: string[]): void {
    NativeMarfeel.setUserSegments(segments);
  }

  /**
   * Remove a specific user segment
   * @param segment The segment name to remove
   */
  static removeUserSegment(segment: string): void {
    NativeMarfeel.removeUserSegment(segment);
  }

  /**
   * Clear all user segments
   */
  static clearUserSegments(): void {
    NativeMarfeel.clearUserSegments();
  }

  /**
   * Set a page-level custom metric
   * @param metric The metric name
   * @param value The metric value (integer)
   */
  static setPageMetric(metric: string, value: number): void {
    NativeMarfeel.setPageMetric(metric, value);
  }

  /**
   * Initialize a multimedia item for tracking
   * @param id The item identifier
   * @param provider The multimedia provider
   * @param providerId The multimedia provider identifier
   * @param type The multimedia type (audio or video)
   * @param metadata The multimedia metadata
   */
  static initializeMultimediaItem(
    id: string,
    provider: string,
    providerId: string,
    type: MultimediaType,
    metadata: MultimediaMetadata
  ): void {
    NativeMarfeel.initializeMultimediaItem(id, provider, providerId, type, metadata);
  }

  /**
   * Register a multimedia event
   * @param id The item identifier
   * @param event The event type
   * @param eventTime The time when the event occurred (in seconds)
   */
  static registerMultimediaEvent(
    id: string,
    event: MultimediaEvent,
    eventTime: number
  ): void {
    NativeMarfeel.registerMultimediaEvent(id, event, eventTime);
  }
}

// Export default and named export
export default Marfeel;
