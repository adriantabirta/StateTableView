//
//  ViewController.swift
//  StateTableView
//
//  Created by Adrian Tabirta on 26.12.2017.
//  Copyright © 2017 Adrian Tabirta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var tableview: UITableView?
	
	/// Array with your data.
	var elements = [String]()
	var networkDelay = 2.0
	
	/// You can use your custom refresh control.
	lazy var refreshControl: UIRefreshControl = {
		$0.tintColor = UIColor.blue
		$0.addTarget(self, action: #selector(self.refreshAction), for: .valueChanged)
		return $0
	}(UIRefreshControl(frame: CGRect.zero))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// this is important to setup
		tableview?.datasourceReference = self
		tableview?.configure(state: .loading(LoadingView(frame: self.tableview?.frame ?? CGRect.zero)))
		tableview?.tableFooterView = UIView()
		loadData()
	}
	
	/// Simulate loading data
	func loadData() {
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + networkDelay) {
			self.elements = ["One", "Two"]
			self.tableview?.reloadData()
			self.tableview?.configure(state: .initialRefreshable(self.refreshControl))
		}
	}
	
	/// Simulate refresh data.
	@objc func refreshAction() {
		// Try loading screen.
		tableview?.configure(state: .loading(LoadingView(frame: self.tableview?.frame ?? CGRect.zero)))
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + networkDelay) {
			
			self.elements = self.elements + ["new one"]
			
			switch self.elements.count {
			case 3:
				// Try empty data view.
				self.tableview?.configure(state: .empty(NoDataView()))
				
			case 4:
				// Try no connection view.
				let placeholder = NoConnectionView(frame: self.tableview?.frame ?? CGRect.zero).onTryAgain(self.refreshAction)
				self.tableview?.configure(state: .noConnection(placeholder))
			default:
				self.tableview?.configure(state: .initialRefreshable(self.refreshControl))
			}
		}
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return elements.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = indexPath.row.description
		return cell
	}
}







