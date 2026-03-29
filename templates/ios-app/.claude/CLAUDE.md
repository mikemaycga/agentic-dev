# iOS App Project

## Project Type
Native iOS application (Swift/SwiftUI)

## Standards
@framework/standards/code-style.md
@framework/standards/testing-standards.md
@framework/standards/security-baseline.md
@framework/standards/git-workflow.md

## Tech Stack
- **Language:** Swift 5.9+
- **UI Framework:** SwiftUI (UIKit for legacy or complex views)
- **Architecture:** MVVM with Combine/async-await
- **Dependencies:** Swift Package Manager
- **Testing:** XCTest (unit), XCUITest (UI)

## Project Conventions
- Views in `Views/` with matching ViewModels in `ViewModels/`
- Services (networking, persistence) in `Services/`
- Models in `Models/`
- Shared utilities in `Utilities/`
- Follow Apple Human Interface Guidelines

## Security Profile
Default: professional-standard. Apps handling health/financial data use enterprise-soc2.

## Deployment
- TestFlight for beta distribution
- App Store Connect for production releases
- Code signing managed via Xcode automatic signing
