//
//  PhotoTouchPreviewViewController.swift
//  DemoTLPhotoPicker
//
//  Created by Tran Anh on 6/7/18.
//  Copyright © 2018 anh. All rights reserved.
//

import UIKit

class PhotoTouchPreviewViewController: UIViewController {

    @IBOutlet weak var imgPreview: UIImageView!
    var image: UIImage?

    public init(image: UIImage) {
        super.init(nibName: "PhotoTouchPreviewViewController", bundle: Bundle(for: PhotoTouchPreviewViewController.self))
        self.image = image
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(image?.size)")
        if let preImage = image {
            imgPreview.image = preImage
        }
        //        imgPreview.image = #imageLiteral(resourceName: "arrow.png")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
