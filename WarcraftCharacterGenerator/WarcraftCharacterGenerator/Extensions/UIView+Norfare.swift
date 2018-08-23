//
//  UIView+Norfare.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/23/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>(name: String) -> T {
        return Bundle.main.loadNibNamed(String(describing: name), owner: nil, options: nil)![0] as! T
    }
}
