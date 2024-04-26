//
//  ImageViewController.swift
//  Cassini
//
//  Created by 홍정민 on 2024/04/23.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var imageURL: NSURL? {
        didSet{
            image = nil
            //화면에 나타나는 것 보장
            if view.window != nil{
                fetchImage()
            }
        }
    }
    
    private func fetchImage(){
        if let url = imageURL {
            DispatchQueue.global(qos: .userInitiated).async {
                let contentOfURL = NSData(contentsOf: url as URL)
                
                DispatchQueue.main.async {
                    if let imageData = contentOfURL {
                        if url == self.imageURL{
                            self.image = UIImage(data: imageData as Data)
                        }else{
                            print("ignored data returned from url \(url)")
                        }
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit() //이미지뷰 사이즈 조절
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    

}
