# Bee Apple iTunes Search (code name: Farfalla)

Searches iTunes search endpoint given a set of search terms, and a media type
https://itunes.apple.com/search?parameterkeyvalue&term=XXXX&media=all

Basic search results information is listed within a table view.  When an item within the results set is selected from the table view, a details view appears with more information about the item.

This project is a sample app, built for Zulilly to demonstrate some of my coding skills.  All aspects of this project were authored by me.  Apple documentation was searched often; and internet search was used extensively to help with Swift syntax.  The only borrowed designed element is the syntax for declaring a Swift singleton (https://krakendev.io/blog/the-right-way-to-write-a-singleton)



## Features

### Swift
The project is implemented using only Swift.

### Apple Search Service
Wraps/abstracts the endpoint and provides exactly two parameter (of the many supported by Apple): term, media.  The search is executed asynchronously with a completion routine.

### Unit Tests
A few unit tests were implemented to exercise the Apple Search service, as well as the Image Cache.  This does not constitute production level code coverage.

### Friendly Names
Media types and result property names are included with singleton wrappers.  These wrapper allow for mapping between the Apple name, and a friendly name.  They also allow for a preferred sorting.

### Model
Search Results, and each Result Item are wrapped to abstract away the serialized form (JSON), and to provide strong typing.

### Image Cache
Once an image is downloaded for display, it is cached so the next display of the same image will not require another download.  A standard notification occurs once the image has been downloaded, allowing UI to be refreshed immediately.

### Accessibility
All text is displayed using logical fonts.  This allows the user to enable larger fonts through the OS Settings, and have the larger fonts reflected within the app.

### Portrait / Landscape / iPhone / iPad / iPhone X
Auto layout is used, and honors the safe area.  This allows the single UI design to be displayed in a variety of orientations and screen sizes. 

### Storyboard / XIB
The app utilizes both storyboard and XIB.

### Lazy Image Load
Everywhere an image is displayed via download, a placeholder activity indicator appear, until the download completes.


## Known Issues

* No UI tests
* Only a few unit tests - no where near production level of unit tests.
* Images not supplied as @2x, @3x, images not using Xcode asset management system
* The main screen’s navigation bar title gets clipped in landscape mode.
* The app needs to be restarted before OS accessibility font sizes are changed.
* The media type selection page does not indicate the currently selected media type.
* Not all properties are visible within the Result Details page.
* No result item “preview” is supported.

