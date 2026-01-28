# CLAUDE.md

This document provides guidance for AI assistants working with the WaterfallTrueCompositionalLayout codebase.

## Project Overview

WaterfallTrueCompositionalLayout is a lightweight Swift library that enables Pinterest-style waterfall/masonry layouts using Apple's `UICollectionViewCompositionalLayout`. Unlike traditional implementations that subclass `UICollectionViewLayout`, this library integrates directly with compositional layout, enabling full support for multiple section types.

- **Author**: Evgeny Shishko
- **License**: MIT
- **Platform**: iOS 14+
- **Swift Version**: 5.5+
- **Dependencies**: None

## Repository Structure

```
WaterfallTrueCompositionalLayout/
├── Sources/WaterfallTrueCompositionalLayout/     # Main library (3 files, ~148 LOC)
│   ├── WaterfallTrueCompositionalLayout.swift     # Public API entry point
│   ├── WaterfallTrueCompositionalLayout+Config.swift   # Configuration struct
│   └── WaterfallTrueCompositionalLayout+LayoutBuilder.swift # Layout algorithm
├── WaterfallTrueCompositionalLayoutDemo/         # iOS demo application
│   └── WaterfallTrueCompositionalLayoutDemo/
│       ├── Screen/                               # MVVM components
│       └── Resources/                            # Assets, storyboards
├── Package.swift                                 # SPM manifest
├── README.md                                     # User documentation
└── LICENSE
```

## Core Architecture

### Library Components

1. **`WaterfallTrueCompositionalLayout.swift`** - Public API
   - Single static method: `makeLayoutSection(config:environment:sectionIndex:)`
   - Returns `NSCollectionLayoutSection` for use in compositional layouts

2. **`WaterfallTrueCompositionalLayout+Config.swift`** - Configuration
   - `Configuration` struct with layout parameters
   - Two closure-based providers: `ItemHeightProvider` and `ItemCountProvider`
   - Default values: 2 columns, 8pt spacing, automatic insets

3. **`WaterfallTrueCompositionalLayout+LayoutBuilder.swift`** - Algorithm
   - Internal `LayoutBuilder` class implementing greedy waterfall algorithm
   - Tracks column heights to place items in shortest column first

### Algorithm

The layout uses a greedy waterfall algorithm:
1. Find the column with minimum current height
2. Place the item at that column's current height position
3. Update column height with item's bottom position
4. Repeat for all items

## Development Workflows

### Building the Library

The library uses Swift Package Manager:

```bash
# Build the package
swift build

# Run tests (if any exist)
swift test
```

### Demo Application

The demo app is in `WaterfallTrueCompositionalLayoutDemo/` and must be opened in Xcode:

1. Open `WaterfallTrueCompositionalLayoutDemo.xcodeproj`
2. Select an iOS simulator (iOS 14+)
3. Build and run

The demo showcases:
- Dynamic column count changes
- Adjustable spacing
- Content inset options
- Item removal on tap

### Adding as a Dependency

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/eeshishko/WaterfallTrueCompositionalLayout.git", from: "1.0.0")
]
```

## Code Conventions

### Swift Style

- **Extension-based organization**: Related functionality is grouped in extensions (Config, LayoutBuilder)
- **File naming**: `ClassName+ExtensionPurpose.swift`
- **Access control**: Public API is explicitly `public`, implementation details are `internal` or `private`
- **Final classes**: Classes are marked `final` when not intended for subclassing

### Documentation

- Public API methods have doc comments with parameter descriptions
- Use `///` for documentation comments
- Include meaningful parameter explanations

### Type Aliases

```swift
typealias ItemHeightProvider = (_ index: Int, _ itemWidth: CGFloat) -> CGFloat
typealias ItemCountProvider = () -> Int
```

### Memory Management

- Use `[weak self]` in closures passed to Configuration to avoid retain cycles
- The library itself does not retain closures beyond layout calculation

## Demo App Patterns

The demo uses MVVM with Combine:

- **ViewModel**: Publishes state changes via `@Published` properties
- **ViewController**: Subscribes to ViewModel, updates UI
- **Diffable Data Source**: Uses `UICollectionViewDiffableDataSource` with `NSDiffableDataSourceSnapshot`

## Testing

Currently, there are no automated unit tests. Validation is done through the demo application. When adding tests:

- Place tests in a `Tests/WaterfallTrueCompositionalLayoutTests/` directory
- Focus on layout calculation accuracy
- Test edge cases: single column, many columns, zero items, items with zero height

## Common Tasks

### Adding a New Configuration Option

1. Add property to `Configuration` struct in `WaterfallTrueCompositionalLayout+Config.swift`
2. Add parameter to `init` with a sensible default value
3. Use the property in `LayoutBuilder` as needed
4. Update demo app to showcase the option

### Modifying the Layout Algorithm

The algorithm is in `WaterfallTrueCompositionalLayout+LayoutBuilder.swift`:
- `columnIndex()`: Finds shortest column
- `frame(for:)`: Calculates item frame
- `itemOrigin(width:)`: Determines item position

### Supporting New iOS Features

- Minimum deployment is iOS 14 (defined in `Package.swift`)
- Use `@available` annotations for newer APIs
- Test on minimum supported iOS version

## Key Files Reference

| File | Purpose |
|------|---------|
| `Sources/.../WaterfallTrueCompositionalLayout.swift` | Public API entry point |
| `Sources/.../WaterfallTrueCompositionalLayout+Config.swift` | Configuration struct |
| `Sources/.../WaterfallTrueCompositionalLayout+LayoutBuilder.swift` | Layout algorithm |
| `Package.swift` | SPM package definition |
| `WaterfallTrueCompositionalLayoutDemo/.../ViewController.swift` | Demo UI controller |
| `WaterfallTrueCompositionalLayoutDemo/.../ViewModel.swift` | Demo state management |

## API Usage Example

```swift
// Create configuration
let config = WaterfallTrueCompositionalLayout.Configuration(
    columnCount: 2,
    interItemSpacing: 8,
    contentInsetsReference: .automatic,
    itemCountProvider: { [weak self] in
        self?.items.count ?? 0
    },
    itemHeightProvider: { [weak self] index, width in
        self?.items[index].height ?? width
    }
)

// Create layout
let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
    WaterfallTrueCompositionalLayout.makeLayoutSection(
        config: config,
        environment: environment,
        sectionIndex: sectionIndex
    )
}
```

## Notes for AI Assistants

- This is a focused, minimal library (~148 lines of code)
- Avoid adding unnecessary complexity or dependencies
- Maintain backwards compatibility with iOS 14
- The library intentionally has no external dependencies
- Changes should preserve the simple, closure-based configuration API
- When suggesting improvements, consider the impact on the public API surface
