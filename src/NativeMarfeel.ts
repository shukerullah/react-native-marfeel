import { TurboModuleRegistry, type TurboModule } from 'react-native';

export interface Spec extends TurboModule {
  // Initialization
  initialize(accountId: string, pageTechnology?: number): void;

  // Page & Screen Tracking
  trackNewPage(url: string, recirculationSource?: string): void;
  trackScreen(screen: string, recirculationSource?: string): void;
  stopTracking(): void;
  setLandingPage(landingPage: string): void;

  // User Identification
  setSiteUserId(userId: string): void;
  getUserId(): string;

  // User Journey
  setUserType(userType: string, customId?: number): void;

  // User RFV
  getRFV(): Promise<string>;

  // Conversions
  trackConversion(conversion: string): void;

  // Consent
  setConsent(hasConsent: boolean): void;

  // Custom Dimensions - Page Vars
  setPageVar(name: string, value: string): void;

  // Custom Dimensions - Session Vars
  setSessionVar(name: string, value: string): void;

  // Custom Dimensions - User Vars
  setUserVar(name: string, value: string): void;

  // User Segments
  addUserSegment(segment: string): void;
  setUserSegments(segments: string[]): void;
  removeUserSegment(segment: string): void;
  clearUserSegments(): void;

  // Custom Metrics
  setPageMetric(metric: string, value: number): void;

  // Multimedia Tracking
  initializeMultimediaItem(
    id: string,
    provider: string,
    providerId: string,
    type: string,
    metadata: Object
  ): void;
  registerMultimediaEvent(id: string, event: string, eventTime: number): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('Marfeel');
