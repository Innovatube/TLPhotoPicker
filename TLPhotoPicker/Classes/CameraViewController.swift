//
//  CameraViewController.swift
//  TLPhotoPicker_Example
//
//  Created by Tran Anh on 5/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import AVFoundation

protocol CameraDelegate: class {
    func getImageFromCamera(image: UIImage)
}

class CameraViewController: UIViewController {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var imgTakePhoto: UIImageView!
    @IBOutlet weak var btnCancel: UIButton!

    weak var cameraDelegate: CameraDelegate?

    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Setup your camera here...
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.photo

        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)

        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }

        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
        }

        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]

        if session!.canAddOutput(stillImageOutput!) {
            session!.addOutput(stillImageOutput!)
            // ...
            // Configure the Live Preview here...
        }

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
        videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
            switch UIDevice.current.orientation {
            case .portrait:
                videoPreviewLayer!.connection?.videoOrientation = .portrait
            case .portraitUpsideDown:
                videoPreviewLayer!.connection?.videoOrientation = .portraitUpsideDown
            case .landscapeLeft:
                videoPreviewLayer!.connection?.videoOrientation = .landscapeLeft
            case .landscapeRight:
                videoPreviewLayer!.connection?.videoOrientation = .landscapeRight
            default:
                videoPreviewLayer!.connection?.videoOrientation = .portrait
            }
        previewView.layer.addSublayer(videoPreviewLayer!)
        session!.startRunning()


    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//        if let connection = self.videoPreviewLayer?.connection {
//            var currentDevice:
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = previewView.bounds
    }

    @IBAction func didPressTakePhoto(sender: UIButton) {

        if let videoConnection = stillImageOutput!.connection(with: AVMediaType.video) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer!)
                    let dataProvider = CGDataProvider(data: imageData! as CFData)
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)

                    let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    self.cameraDelegate?.getImageFromCamera(image: image)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }

    @IBAction func dismissCamera() {
        self.dismiss(animated: true, completion: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
