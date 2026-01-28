# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

[1.0.0]: https://github.com/eeshishko/WaterfallTrueCompositionalLayout/releases/tag/1.0.0
