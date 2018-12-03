//
//  ViewController.swift
//  SpeedTestBerec
//
//  Created by Giuliano Pes on 07/11/2018.
//  Copyright © 2018 Giuliano Pes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var mediaLabel: UILabel!
    @IBOutlet weak var varianzaLabel: UILabel!
    
    @IBOutlet weak var stimaDownloadLabel: UILabel!
    @IBOutlet weak var stimaUploadLabel: UILabel!
    
    @IBOutlet weak var berecDownloadLabel: UILabel!
    @IBOutlet weak var berecUploadLabel: UILabel!
    
    @IBOutlet weak var mainTestButton: UIButton!
    @IBOutlet weak var stimaDownloadButton: UIButton!
    @IBOutlet weak var stimaUploadButton: UIButton!
    @IBOutlet weak var berecDownloadButton: UIButton!
    @IBOutlet weak var berecUploadButton: UIButton!
    
    @IBOutlet weak var startPingButton: UIButton!
    @IBOutlet weak var stopPingButton: UIButton!
    
    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var progressView2: UIProgressView!
    @IBOutlet weak var progressView3: UIProgressView!
    
    @IBOutlet weak var textViewPingResult: UITextView!
    
    /*
    var hostName = "192.168.1.1"
    var pinger: SimplePing?
    
    var sendTimer:Timer?
    var sentTime: TimeInterval = 0
    */
    
    //parte ICMP Ping
    var pingTest:PingTest?
    
    //parte BEREC
    var test:Test?
    //let stringUrl:String = "http://192.168.1.100:81/html/randomData/"
    
    //let ipUrl:String = "192.168.64.2"
    let ipUrl:String = "192.168.1.1"
    //let stringUrl:String = "http://192.168.64.2/exampleServer/"
    let stringUrl:String = "http://192.168.1.4/exampleServer/"

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTestButton.layer.cornerRadius = 10.0
        stimaDownloadButton.layer.cornerRadius = 10.0
        stimaUploadButton.layer.cornerRadius = 10.0
        berecDownloadButton.layer.cornerRadius = 10.0
        berecUploadButton.layer.cornerRadius = 10.0
        startPingButton.layer.cornerRadius = 10.0
        stopPingButton.layer.cornerRadius = 10.0
        textViewPingResult.isEditable = false
        
        titleLabel.layer.borderWidth = 1.0
        titleLabel.layer.cornerRadius = 10.0
        //titleLabel.layer.borderColor = UIColor.white.cgColor
        titleLabel.layer.masksToBounds = true
        
        stimaDownloadLabel.layer.borderWidth = 1.0
        stimaDownloadLabel.layer.cornerRadius = 10.0
        stimaDownloadLabel.layer.borderColor = UIColor.white.cgColor
        
        stimaUploadLabel.layer.borderWidth = 1.0
        stimaUploadLabel.layer.cornerRadius = 10.0
        stimaUploadLabel.layer.borderColor = UIColor.white.cgColor
        
        berecDownloadLabel.layer.borderWidth = 1.0
        berecDownloadLabel.layer.cornerRadius = 10.0
        berecDownloadLabel.layer.borderColor = UIColor.white.cgColor
        
        berecUploadLabel.layer.borderWidth = 1.0
        berecUploadLabel.layer.cornerRadius = 10.0
        berecUploadLabel.layer.borderColor = UIColor.white.cgColor
        
        mediaLabel.layer.borderWidth = 1.0
        mediaLabel.layer.cornerRadius = 10.0
        mediaLabel.layer.borderColor = UIColor.white.cgColor
        
        varianzaLabel.layer.borderWidth = 1.0
        varianzaLabel.layer.cornerRadius = 10.0
        varianzaLabel.layer.borderColor = UIColor.white.cgColor
        
        textViewPingResult.layer.borderWidth = 1.0
        textViewPingResult.layer.cornerRadius = 10.0
        textViewPingResult.layer.borderColor = UIColor.white.cgColor
        
    }
}

extension ViewController{//Test Ping
    @IBAction func startPingButton(_ sender: UIButton) {
        print("start")
        //self.pingTest = PingTest.init(hostAddress: "192.168.1.100",view: self)
        self.pingTest = PingTest.init(hostAddress: ipUrl,view: self)
        self.pingTest!.start()
    }
    
    @IBAction func stopPingButton(_ sender: UIButton) {
        print("stop")
        self.pingTest!.stop()
    }
    
    func updateMediaVarianza(media:Double,varianza:Double){
        DispatchQueue.main.async{
            let strMedia = String(media)
            let strVarianza = String(varianza)
            let indexMedia = strMedia.index(strMedia.startIndex, offsetBy: 12)
            let indexVarianza = strVarianza.index(strVarianza.startIndex, offsetBy: 12)
            
            self.mediaLabel.text = "\(strMedia[...indexMedia]) ms"
            self.varianzaLabel.text = "\(strVarianza[...indexVarianza]) ms"
        }
    }
}

extension ViewController{
    
    @IBAction func tapMainTest(_ sender: UIButton) {
        self.test = Test.init(view: self, stringUrl: self.stringUrl, sequentialTest: true)
        test!.doEstimatedDownloadTest(seconds: 4)
    }
    
    
    @IBAction func tapStimaDownload(_ sender: UIButton) {
        self.test = Test.init(view: self, stringUrl: self.stringUrl,sequentialTest: false)
        self.test!.doEstimatedDownloadTest(seconds: 4)
    }
    
    @IBAction func tapStimaUpload(_ sender: UIButton) {
        self.test = Test.init(view: self, stringUrl: self.stringUrl,sequentialTest: false)
        self.test!.doEstimatedUploadTest(seconds: 4)
    }
    
    @IBAction func tapBerecDownload(_ sender: UIButton) {
        self.test = Test.init(view: self, stringUrl: self.stringUrl,sequentialTest: false)
        self.test!.doDownloadBerecTest()
    }
    
    @IBAction func tapBerecUpload(_ sender: UIButton) {
        self.test = Test.init(view: self, stringUrl: self.stringUrl,sequentialTest: false)
        self.test!.doUploadBerecTest()
    }
}
extension ViewController{
    //
    func showEstimatedDownloadResult(estimatedSpeed: Double){
        if estimatedSpeed == 0.0 {return}
        DispatchQueue.main.async {
            let str = String(estimatedSpeed)
            let index = str.index(str.startIndex, offsetBy: 8)
            self.stimaDownloadLabel.text = "\(str[...index]) MB/s"
        }
    }
    
    func showEstimatedUploadResult(estimatedSpeed: Double){
        if estimatedSpeed == 0.0 {return}
        DispatchQueue.main.async {
            let str = String(estimatedSpeed)
            let index = str.index(str.startIndex, offsetBy: 8)
            self.stimaUploadLabel.text = "\(str[...index]) MB/s"
        }
    }
    
    func showBerecDownloadResult(estimatedSpeed: Double){
        if estimatedSpeed == 0.0 {return}
        DispatchQueue.main.async {
            let str = String(estimatedSpeed)
            let index = str.index(str.startIndex, offsetBy: 8)
            self.berecDownloadLabel.text = "\(str[...index]) MB/s"
        }
    }
    
    func showBerecUploadResult(estimatedSpeed: Double){
        if estimatedSpeed == 0.0 {return}
        DispatchQueue.main.async {
            let str = String(estimatedSpeed)
            let index = str.index(str.startIndex, offsetBy: 8)
            self.berecUploadLabel.text = "\(str[...index]) MB/s"
        }
    }
}


//aggiornamento dei progressi
extension ViewController{
    //download
    func updateProgressDownload(download: Download){
        switch download.id{
        case 1:
            DispatchQueue.main.async {
                self.label1.text = "\(Int(download.progress!*100))%"
                self.progressView1.progress = download.progress!
            }
            return
        case 2:
            DispatchQueue.main.async {
                self.label2.text = "\(Int(download.progress!*100))%"
                self.progressView2.progress = download.progress!
            }
            return
        case 3:
            DispatchQueue.main.async {
                self.label3.text = "\(Int(download.progress!*100))%"
                self.progressView3.progress = download.progress!
            }
            return
        default:
            print("nessun download associato")
            return
        }
    }
    
    //upload
    func updateProgressUpload(upload: Upload){
        switch upload.id{
        case 1:
            DispatchQueue.main.async {
                self.label1.text = "\(Int(upload.progress!*100))%"
                self.progressView1.progress = upload.progress!
            }
            return
        case 2:
            DispatchQueue.main.async {
                self.label2.text = "\(Int(upload.progress!*100))%"
                self.progressView2.progress = upload.progress!
                
            }
            return
        case 3:
            DispatchQueue.main.async {
                self.label3.text = "\(Int(upload.progress!*100))%"
                self.progressView3.progress = upload.progress!
            }
            return
        default:
            print("nessun download associato")
            return
        }
    }
}
//update textViewPingResult
extension ViewController{
    func updateTextViewPingResult( numero:String, latenza:String){
        DispatchQueue.main.async {
            self.textViewPingResult.text.append(contentsOf: "\n #\(numero)\n \(latenza) ms")
        }
    }
}
