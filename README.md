# WaterfallTrueCompositionalLayout 🖼️

This library allows you to create pinterest-like layout using collection view compositional layout. Compare to other solutions I've found on Internet, they provide general UICollectionViewLayout which doesn't allow you to use full advantage of compositional layout having various section appearances.

![](https://user-images.githubusercontent.com/14946233/203838156-1f3c7e0d-cd9a-40ec-b652-8b89206a26bb.gif)

## Add a dependency using SPM

WaterfallTrueCompositionalLayout is accessible through [Swift Package Manager](https://swift.org/package-manager). 

To use it inside your project, add it through XCode project Settings or as a dependency within your Package.swift manifest:
```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/eeshishko/WaterfallTrueCompositionalLayout.git", from: "1.0.0")
    ],
)
```

## API

First, create ```WaterfallTrueCompositionalLayout.Configuration``` instance describing your layout:
```swift
let configuration = WaterfallTrueCompositionalLayout.Configuration(
    columnCount: 2,
    interItemSpacing: 8,
    contentInsetsReference: .automatic,
    itemCountProvider: { [weak self] in
        return 10
    },
    itemHeightProvider: { [weak self] row, width in
        return width * 1.2
    }
)
 ```

Then pass it along with enviroment and section index, which are available through ```UICollectionViewCompositionalLayout``` initializater:

```swift
let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
    WaterfallTrueCompositionalLayout.makeLayoutSection(
        config: configuration,
        enviroment: enviroment,
        sectionIndex: sectionIndex
    )
}
```

For exploring possibilities of the lib and how to use it properly, you can have a look at the [demo project](https://github.com/eeshishko/WaterfallTrueCompositionalLayout/tree/main/WaterfallTrueCompositionalLayoutDemo) in the repository.

# Contributing
Feel free to raise any issues, improvements or pull requests 😊
