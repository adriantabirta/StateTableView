//
//  UITableView.swift
//  StateTableView
//
//  Created by Adrian Tabirta on 21.02.2018.
//  Copyright © 2018 Adrian Tabirta. All rights reserved.
//

import UIKit

internal extension UITableView {
	
	private struct CustomProperties {
		static var state: StateType 		= StateType.initial
		static var datasourceKey: UInt8		= 0
	}
	
	private func addDataSource() {
		dataSource = datasourceReference
		reloadData()
	}
	
	private func removeDataSource() {
		dataSource = nil
		reloadData()
	}
	
	private func removeRefreshControl() {
		contentOffset = CGPoint.zero
		refreshControl?.endRefreshing()
		refreshControl = nil
	}
}

public extension UITableView {
	
	/// State enum for setting placeholder on tableview
	public enum StateType {
		
		/**
		Initial tableview state. Just white backgound.
		*/
		case initial
		
		/**
		Initial refreshable is default tableview placeholder with
		option to refresh.
		- parameter UIRefreshControl: UIRefreshControl for tableview refresh.

		*/
		case initialRefreshable(UIRefreshControl)
		
		/**
		Empty state is where you could set a default placeholder with
		title and subtitle.
		- parameter UIView: Custom `Placeholder` view.
		*/
		case empty(UIView)
		
		/**
		Loading state is used for loading data or refreshig it.
		- parameter UIView: Custom `Loading` view. Use an animating spiner or smth.
		*/
		case loading(UIView)
		
		/**
		No Connection state is for any connection problems.
		- parameter UIView: Custom `NoConnection` view.
		*/
		case noConnection(UIView)
	}
	
	/// Required. Datasource reference for updating tableview data.
	public var datasourceReference: UITableViewDataSource? {
		get{ return objc_getAssociatedObject(self, &CustomProperties.datasourceKey) as? UITableViewDataSource }
		set{
			guard let value = newValue else { return }
			objc_setAssociatedObject(self, &CustomProperties.datasourceKey, value, .OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	/// State machine for tableview.
	public private(set) var state: StateType? {
		get{ return objc_getAssociatedObject(self, &CustomProperties.state) as? StateType }
		set{
			guard let value = newValue else { return }
			objc_setAssociatedObject(self, &CustomProperties.state, value, .OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	/// Configure state for tableview.
	public func configure(state: StateType) {
		self.state = state
		
		switch state {
		case .initial:
			addDataSource()
			
			removeRefreshControl()
			backgroundView = nil
			
		case let .initialRefreshable(refresh):
			addDataSource()
			
			refreshControl = refresh
			backgroundView = nil
			
		case let .loading(view):
			refreshControl?.endRefreshing()
			removeDataSource()
			
			view.frame = self.bounds
			backgroundView = view
			
		case let .empty(view):
			refreshControl?.endRefreshing()
			removeDataSource()
			
			view.frame = self.bounds
			backgroundView = view
			
		case let .noConnection(view):
			removeDataSource()
			
			removeRefreshControl()
			view.frame = self.bounds
			backgroundView = view
		}
	}
}


