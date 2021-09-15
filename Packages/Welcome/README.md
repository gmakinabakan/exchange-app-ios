
# Welcome

This package implements the welcome screen. 

## DependencyObject
This object needs be created from the application that uses this package and needs to be supplemented from the environment object.

    public final class WelcomeDependencyObject: ObservableObject, DataTransferProtocol {
        public var nextView: AnyView
        public var headerMessage: String
        public var captionMessage: String
        public var popupMessage: String
        public var initialDataAPI: APIBaseProtocol?
        public var uniqueDataKey: String?
    }

*headerMessage, captionMessage and popupMessage* are the strings that will be displayed on the Welcome screen. The formatting and the placement is in the view itself. *initialDataAPI* is the API implementation that will be called when the user taps on "Let's Go" button. When the data is retrieved, *netxView* will be displayed on the screen. *uniqueDataKey* is the key that is being used to transfer the data in key-value storage.

## Model

### WelcomeDataProtocol

    protocol WelcomeDataProtocol {
        func dataRetrievalCompleted()
    }

This is an internal protocol that makes sure the view gets the data loaded event.

## Helpers

### WelcomeHelper

This class implements *DataSourceBaseProtocol* and calls the initial API. When the data is loaded, it uses data transfer object and sets the data with the given key. 

## WelcomeView
This is the actual implementation of the Welcome view. This displays the messages, popup and has the navigational logic. This viewe utilizes WelcomerHelper to instantiate data loading for the next screen.
