//
//  CustomSplitViewController.swift
//  Cassini
//
//  Created by 홍정민 on 2024/04/27.
//

import UIKit

class CustomSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    //detail에서 보일 이미지가 없다면 master위에 얹어두고 싶지 않음(true 반환)
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        if primaryViewController.contentViewController is CassiniViewController {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController, ivc.imageURL == nil {
                return true //직접 처리하겠다는 뜻(detail에 이미지 없으면 master 덮지 않도록)
            }
        }
        return false //시스템이 처리
    }
    
}
