//
//  NoDataView.swift
//  StateTableView
//
//  Created by Adrian Tabirta on 21.02.2018.
//  Copyright © 2018 Adrian Tabirta. All rights reserved.
//

import UIKit

final class NoDataView: UIView {
	
	convenience init() {
		self.init(frame: CGRect.zero)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configure()
	}
	
	private func configure() {
		let bundle = Bundle(for: NoDataView.self)
		let view = bundle.loadNibNamed("NoDataView", owner: self, options: nil)?.first as! UIView
		addSubview(view)
		view.frame = self.bounds
	}	
}
