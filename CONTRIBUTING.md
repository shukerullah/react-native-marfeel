# Contributing

Contributions are welcome! Please read the [code of conduct](./CODE_OF_CONDUCT.md) before contributing.

## Development Workflow

### Setup

```sh
# Install dependencies
yarn install

# Type check
yarn typecheck

# Clean build artifacts
yarn clean

# Build the library
yarn prepare
```

### Making Changes

1. **Source files**: Edit files in `src/`, `android/`, or `ios/`
2. **Android**: Open `android/` in Android Studio
3. **iOS**: Open the `.xcworkspace` file in Xcode after running `pod install`
4. **TypeScript**: Run `yarn typecheck` to check types

### Commit Convention

Follow [conventional commits](https://www.conventionalcommits.org/):

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `chore`: Tooling/config changes

### Sending a Pull Request

- Keep PRs small and focused
- Discuss API changes in an issue first
- Update documentation if needed
