//
//  ViewController.swift
//  SkinShield3
//
//  Created by Sudhit Rao on 4/17/20.
//  Copyright © 2020 Sudhit Rao. All rights reserved.
//

import UIKit
import AVKit
import CoreML
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var doneButton: UIButton!
    
    var conf : String = ""
    var cont : Bool = true
    
    @IBAction func donebutton(_ sender: Any) {
        print("buttonnnnnnnnnnnnnnnnnnnnnnnnnnnnn")
        self.performSegue(withIdentifier: "donescreensegue", sender: self)
        cont = false
    }
    
    @IBOutlet weak var cameraDisplay: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCamera()
        doneButton.layer.cornerRadius = 4
    }
    
    func setUpCamera(){
        
        guard let device  = AVCaptureDevice.default( for: .video)else{return}
        guard let input = try? AVCaptureDeviceInput(device: device) else{return}
        print("Camera has started")
        let session = AVCaptureSession()
        session.sessionPreset = .hd4K3840x2160
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.frame
        cameraDisplay.layer.addSublayer(previewLayer)
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "CameraOutput"))
        
        session.addInput(input)
        session.addOutput(output)
        session.startRunning()
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
       
        //print("jhsb")
        guard let sampleBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else{return}
        scanImage(buffer: sampleBuffer)
        //print("jhsb")
        
        
    }
    
    
    func scanImage(buffer: CVPixelBuffer){
        
        guard let model = try? VNCoreMLModel(for:skinML().model) else {return}
        //print("hgi")
        let request = VNCoreMLRequest(model: model) { request, _ in
        guard let results = request.results as? [VNClassificationObservation] else {return }
        
        guard let mostConfidentResult = results.first else{return}
            self.conf = mostConfidentResult.identifier
             
            //print(mostConfidentResult.identifier)
            
            DispatchQueue.main.async {
                
                if mostConfidentResult.confidence >= 0.6{
                    let confidenceText = " \(Int(mostConfidentResult.confidence * 100.0))%"
                switch mostConfidentResult.identifier{
                case "poisonivy": self.resultLabel.text = "poison ivy \(confidenceText)"
                case "eczema": self.resultLabel.text = "eczema \(confidenceText)"
                default:
                    return;
                    }
            }
            
                else {self.resultLabel.text = "I recommend going to the doctor for more information"}
            }
                
        }
        
        
      
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: buffer, options: [:])
        do{
        try requestHandler.perform([request])
        }
        catch{
            print(error)
        }
    }
    
    
}



