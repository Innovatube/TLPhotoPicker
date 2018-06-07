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
    init(image: UIImage?) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(image?.size)")
        if let image123 = image {
            imgPreview.image = image123
        }
//        imgPreview.image = #imageLiteral(resourceName: "arrow.png")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
