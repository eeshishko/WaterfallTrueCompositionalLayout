# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-01-28

### Added
- `ColumnBehavior` enum to control how items are assigned to columns
  - `lowestHeight`: Items placed in column with lowest height (default, existing behavior)
  - `sequential`: Items placed sequentially across columns (0→col0, 1→col1, 2→col0, etc.)
  - `custom(ColumnIndexProvider)`: Custom column assignment via closure
- `columnBehavior` parameter in `Configuration` struct
- `ColumnIndexProvider` typealias for custom column assignment closures

### Fixed
- Resolved issue where height changes in one column would affect adjacent columns (#3)

## [1.0.0] - 2022-11-24

### Added
- Initial release of WaterfallTrueCompositionalLayout
- Pinterest-style waterfall/masonry layout using `UICollectionViewCompositionalLayout`
- `Configuration` struct with customizable parameters:
  - `columnCount`: Number of columns in the layout
  - `interItemSpacing`: Spacing between items
  - `contentInsetsReference`: Content insets configuration
  - `itemCountProvider`: Closure to provide item count
  - `itemHeightProvider`: Closure to provide item heights
- `makeLayoutSection(config:environment:sectionIndex:)` public API
- Demo application showcasing library features
- Support for iOS 14+
- Swift Package Manager support

[1.1.0]: https://github.com/eeshishko/WaterfallTrueCompositionalLayout/releases/tag/1.1.0
[1.0.0]: https://github.com/eeshishko/WaterfallTrueCompositionalLayout/releases/tag/1.0.0
