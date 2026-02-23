## What's New in 1.1.0

### 🎉 New Platform Support
- Added **visionOS 1.0+** support - AppEntitlements now works on all Apple platforms

### 🔧 Improvements
- **Build Plugin Migration**: Replaced Swift Macros with Build Plugin for code generation
  - Eliminates security prompts during build
  - Faster build times
  - More maintainable code generation pipeline
- **Smart Platform Filtering**: Code generator now only emits `@available` attributes for platforms listed in `supportedPlatforms`
  - Package.swift is now the single source of truth for platform availability
  - Removes redundant availability attributes matching package minimum versions

### 📚 Documentation
- Updated README and DocC articles to reflect visionOS support
- Improved inline documentation for generated entitlement properties

---

**Full Changelog**: https://github.com/wiedem/app-entitlements/compare/1.0.0...1.1.0
