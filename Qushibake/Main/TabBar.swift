//
//  TabBar.swift
//  Qushibake
//
//  Created by 孙春磊 on 2020/8/18.
//  Copyright © 2020 coder. All rights reserved.
//

import UIKit

class TabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews();
        
        for button in subviews where button is UIControl {
            var frame = button.frame;
            frame.origin.y = 10;
            button.frame = frame;
        }
    }

}
