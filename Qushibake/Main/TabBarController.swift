//
//  TabBarController.swift
//  Qushibake
//
//  Created by 孙春磊 on 2020/8/18.
//  Copyright © 2020 coder. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        setValue(TabBar(), forKey:"tabBar")
        tabBar.barTintColor = UIColor.white;// 取消穿透效果
                
        addChild("糗事","icon_main","icon_main_active",HomeViewController.self);
        addChild("直播","main_tab_live","main_tab_live_active",LiveViewController.self);
        addChild("动态","main_tab_qbfriends","main_tab_qbfriends_active",TrendViewController.self);

    }
    
    func addChild(_ title:String ,
                  _ image:String,
                  _ selectedImage:String,
                  _ type:UIViewController.Type){
        
        let child = UINavigationController(rootViewController: type.init());
        child.title = title;
        child.tabBarItem.image = UIImage(named: image);
        child.tabBarItem.selectedImage = UIImage(named: selectedImage);
        
        child.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: UIControl.State.selected)
        
        addChild(child);
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
