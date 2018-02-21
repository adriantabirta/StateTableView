# StateTableView

### TableView exemple for states.

###### Tableview extenions for statle like:
- [x] initial
- [x] initialRefreshable
- [x] empty
- [x] loading
- [x] noConnection

###### This it is an exemple how to make tableview placeholders. Customize views like you want and use it.

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
