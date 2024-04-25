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
            if let ivc = segue.destination as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                print("\(imageName)")
                ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                ivc.title = imageName
            }
        }
    }
    
}

