# FlickrSearch

This is an iOS app for searching public photos on Flickr.

## Specification
iOS 13, Swift, UIKit

## Author
Joacim Nidén, jocke@niden.se

### Utilities
Contains files that are not tied to certain pages, for example **transitions** and **extensions**

### Resources
Contains assets and fonts (if there would be any)

### Models
Contains dynamic **enums** and **structs**

### Services
Files that are connection to something else. In this case, the **APIManager** and **FlickrSettings**

### Scenes
ViewControllers, Cells and Presenters.


## How it's built
The app is built with StoryBoards and consists of 3 pages, **Search**, **Detail** and **Zoom**. Where search is the landing screen and will start searching when you press search

Search has a **ViewController** and a **Presenter** which* handles all connection with the api and all logic. The **ViewController** should not contain anything related to APIs. The **Presenter** should handle all the data.

### SearchViewController
The view has 3 parts, the **Searchbar**, a **CollectionView** and a **PaginationView**

### ImageDetails
Contains of one image and a label. The label is using attributed string to separate the fields

### Transition
The default modal opening is replaced by a custom transition called **GrowAnimator** that makes the transition a bit more exciting.

### Models
The app is separating between the view models and the api models. The API models should not be sent around the app. They are only there to populate the view models.

### Services
The app is using built in **NSURLSession** for API Services in a file called **APIManager** and a **FlickrSettings** that contains the routing urls displayed as enums.

