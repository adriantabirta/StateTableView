# StateTableView

### TableView exemple for states.

###### Tableview extenions for statle like:
- [x] initial
- [x] initialRefreshable
- [x] empty
- [x] loading
- [x] noConnection

###### This it is an exemple how to make tableview placeholders. Customize views like you want and use it.

###### Gif

![Alt Text](https://media.giphy.com/media/ulKNZPl7O5bHj2Gm9Y/giphy.gif)

## Getting Started

Is easy to implement, just drag and drom into your project folders: **Views** and **Extensions**.
Download repository and run on the simulator. Application simulate network requests with different responses.
Refresh for simulate requests.

Here is an exemple code how to use it: 
```swift
class ViewController: UIViewController {
  
  	// ...

	override func viewDidLoad() {
		super.viewDidLoad()
		// this is important to setup
		tableview?.datasourceReference = self
		
		// configure initial tableview state
		tableview?.configure(state: .loading(LoadingView(frame: self.tableview?.frame ?? CGRect.zero)))
	}
  
  	func loadData() {
  
     		 // create an loading view and set it.
     	 	let loagindView =  LoadingView(frame: self.tableview?.frame)
  		tableview?.configure(state: .loading(loagindView))
      
     	 	// ... you loading data code here
      
      		// on empty data, use your placehoder 
      		let nodataView = NoDataView()
      		self.tableview?.configure(state: .empty(nodataView))


		// on lost connection
      		let noConnectionView = NoConnectionView(frame: self.tableview?.frame ?? CGRect.zero).onTryAgain(self.refreshAction)
      		self.tableview?.configure(state: .noConnection(noConnectionView))
      
  }
  
  func refreshAction() {
    // ...
  }
 
  
  
```
