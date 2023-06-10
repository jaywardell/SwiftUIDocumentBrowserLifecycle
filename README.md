# SwiftUIDocumentBrowserLifecycle

When using a DocumentGroup in the SwiftUI Lifecycle,
the first view that the user sees is a `UIDocumentBrowserViewController`.
So it's not easy to do anything special with the UI at that point 
from a SwiftUI perspective
(eg put a button in the toolbar that can present a sheet).

This package sets up the bridging code needed
to respond to some simple life-cycle events
for the `UIDocumentBrowserViewController`,
so that simple UI modifications like this can be done.

## Listening for UIDocumentBrowserViewController Lifecycle Events 
Create a `DocumentBrowserEventListener`,
passing in one of the events available 
(`wasCreated`, `becameActive`, or `becameInactive`).
In the callback, do whatever work you want to do.
The ideal place to do this would be in a 
`UIApplicationDelegate` marked with `@UIApplicationDelegateAdaptor`

Note that, as far as SwiftUI is concerned,
the callback is being called outside the SwiftUI Lifecycle,
so you must interact with the view controller passed in 
as a UIKit view controller.  
You cannot access any `@Environment` variables 
that are provided by the App struct, for example.

## Adding toolbar items to the UIDocumentBrowserViewController

There's also an extension on `UIDocumentBrowserViewController` that simplifies the process of adding a toolbar button to it. Just call `addLeadingToolbarItem()`, passing in a `UIBarButtonItem` and a callback for the work that you would like to do. The callback gives you back the `UIDocumentBrowserViewController`. There are defaults for most options you would want to change and an override that lets you just pass in a SF Symols system image name.

## Example Usage

The following adds a toolbar button to the `UIDocumentBrowserViewController` that brings up a sheet containing a new SwiftUI view 

``` swift
final class AppDelegate: NSObject, UIApplicationDelegate {

    let listener: DocumentBrowserEventListener

    override init() {

        self.listener = DocumentBrowserEventListener(.wasCreated) { documentBrowserViewController in
            documentBrowserViewController.addToolbarItem(systemImageName: "scribble") { browser in

                let exampleView = UIHostingController(rootView:
                    Text("Hello, World!")
                )

                browser.present(exampleView, animated: true)
            }
        }

        super.init()
    }
}
```

## Compatibility

This package has only been tested against iOS 16, and has not been tested against the new iOS 17 beta as of 6/10/23.
