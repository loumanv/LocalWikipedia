# LocalWikipedia

An iPhone app that displays Wikipedia articles for nearby locations. The app is written in Swift and supports iOS 9 or above. Uses Carthage and Alamofire.

It uses the  MediaWiki action API described here:
https://www.mediawiki.org/wiki/Extension:GeoData#API

- On launch, the app begins monitoring device location and automatically refreshes a list of nearby locations when the user moves by 20 metres or more.
- Presents the list of nearby locations in a table view; including the distance from the user in metres in real time.
- When the user taps on a location, it opens the associated Wikipedia article in a SFSafariViewController.
