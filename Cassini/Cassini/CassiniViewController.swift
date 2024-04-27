//
//  CassiniViewController.swift
//  Cassini
//
//  Created by 홍정민 on 2024/04/25.
//

import UIKit

class CassiniViewController: UIViewController {
    
    private struct Storyboard {
        static let showImageSegue = "Show Image"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showImageSegue {
            if let ivc = segue.destination.contentViewController as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                ivc.title = imageName
            }
        }
    }
    
    @IBAction func showImage(_ sender: UIButton) {
        //SplitView 상태에서만 가능하기 때문에 아닌 경우 세그웨이 연결이 필요
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            let imageName = sender.currentTitle
            ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
            ivc.title = imageName
        }else{
            //스토리 보드 상 segue 존재해야 함
            performSegue(withIdentifier: Storyboard.showImageSegue, sender: sender)
        }
    }
}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }else{
            return self
        }
    }
}

