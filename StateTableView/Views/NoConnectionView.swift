//
//  NoConnectionView.swift
//  StateTableView
//
//  Created by Adrian Tabirta on 21.02.2018.
//  Copyright © 2018 Adrian Tabirta. All rights reserved.
//

import UIKit

final class NoConnectionView: UIView {
	
	private var tryClosure: () -> Void = { }
	
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
		let bundle = Bundle(for: NoConnectionView.self)
		let view = bundle.loadNibNamed("NoConnectionView", owner: self, options: nil)?.first as! UIView
		addSubview(view)
		view.frame = self.bounds
	}
	
	@IBAction fileprivate func tryAgainAction(_ sender: UIButton) {
		tryClosure()
	}
	
	func onTryAgain(_ closure: @escaping () -> Void) -> Self {
		tryClosure = closure
		return self
	}
	
}
