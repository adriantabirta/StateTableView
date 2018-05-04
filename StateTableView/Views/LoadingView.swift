//
//  LoadingView.swift
//  StateTableView
//
//  Created by Adrian Tabirta on 26.12.2017.
//  Copyright © 2017 Adrian Tabirta. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
	
	fileprivate lazy var indicator: UIActivityIndicatorView = {
		$0.center 	= self.center 
		$0.color	= UIColor.blue
		$0.startAnimating()
		return $0
	}(UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge))
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configure()
	}
	
	private func configure() {
		backgroundColor = .white
		// indicator.center = self.center
		addSubview(indicator)
		
		let centerX = NSLayoutConstraint(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
		let centerY = NSLayoutConstraint(item: indicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
		
		NSLayoutConstraint.activate([centerX, centerY])
	}
}
