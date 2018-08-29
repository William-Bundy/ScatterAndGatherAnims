//
//  ViewController.swift
//  ScatterAndGatherAnims
//
//  Created by William Bundy on 8/29/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import UIKit


func random(_ mm:Double, _ mx:Double) -> CGFloat
{
	let r = Double(arc4random_uniform(UINT32_MAX)) / Double(UINT32_MAX)
	return CGFloat(r * (mx - mm) + mm);
}

func random(_ mm:CGFloat, _ mx:CGFloat) -> CGFloat
{
	let r = Double(arc4random_uniform(UINT32_MAX)) / Double(UINT32_MAX)
	return CGFloat(r) * (mx - mm) + mm;
}


class ViewController: UIViewController {

	var startXY:CGPoint = CGPoint(x:400, y:100)
	var labels:[UILabel] = []
	var mode:Bool = true
	var logo:UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()

		logo = UIImageView(frame: CGRect(x:15, y:view.frame.size.height/2 - 30, width:120, height:120))
		logo.contentMode = .scaleAspectFit
		logo.image = UIImage(named: "LambdaLogo")
		view.addSubview(logo)

		startXY.y = view.frame.size.height / 2
		startXY.x = 150 - 20
		var head = startXY.x
		for c in "Lambda" {
			let l = UILabel()
			l.font = UIFont.systemFont(ofSize: 40)
			l.tintColor = .black
			l.text = String(c)
			var f = l.frame
			f.origin.x = head
			f.origin.y = startXY.y
			f.size = l.intrinsicContentSize
			l.frame = f
			head += l.intrinsicContentSize.width

			view.addSubview(l)
			labels.append(l)
		}


	}


	@IBAction func toggle(_ sender: Any) {
		defer { mode = !mode }

		// true == scatter
		if mode {
			UIView.animate(withDuration:2.0) {
				self.logo.alpha = 0
			}
			for l in labels {
				UIView.animate(withDuration: 2.0) {
					var matrix = l.transform
					matrix = matrix.rotated(by: random(-180.0, 180.0))
					let sz = self.view.frame.size
					// these are in local coordinates because... reasons
					matrix.tx =  random(-self.startXY.x, sz.width - self.startXY.x)
					matrix.ty = random(-self.startXY.y, sz.height - self.startXY.y)
					l.transform = matrix
				}
			}
		} else {

			UIView.animate(withDuration:2.0) {
				self.logo.alpha = 1
			}
			var head = startXY.x
			for l in labels {
				UIView.animate(withDuration: 2.0) {
					l.transform = CGAffineTransform.identity
					var f = l.frame
					f.origin.x = head
					f.origin.y = self.startXY.y

					l.frame = f
				}
				head += l.intrinsicContentSize.width
			}
		}
	}

}

