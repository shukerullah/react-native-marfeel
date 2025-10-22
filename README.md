# react-native-marfeel

React Native wrapper for Marfeel SDK - Analytics and tracking solution for mobile apps.

## Installation

```sh
npm install react-native-marfeel
```

### Android Setup

Add the Marfeel Maven repository to your `android/build.gradle`:

```gradle
allprojects {
    repositories {
        // ... other repositories
        maven {
            url "https://repositories.mrf.io/nexus/repository/mvn-marfeel-public/"
        }
    }
}
```

### iOS Setup

```sh
cd ios && pod install
```

## Usage

```js
import Marfeel from 'react-native-marfeel';

// Initialize the SDK
await Marfeel.initialize('YOUR_ACCOUNT_ID');

// Track a page
Marfeel.trackNewPage('https://example.com/article');
```

Full documentation coming soon.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development workflow and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for community guidelines.

## License

MIT
