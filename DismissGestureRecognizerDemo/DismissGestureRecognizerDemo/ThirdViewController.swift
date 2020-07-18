//
//  ThirdViewController.swift
//  DismissGestureRecognizerDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2020/7/19.
//  Copyright © 2020 janlionly<janlionly@gmail.com>. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Third"
        
        // this will not take effect, just for popping view controller
        dismissType = .swipeRightForFullScreen
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
