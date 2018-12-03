//
//  PingTest.swift
//  SpeedTestBerec
//
//  Created by Giuliano Pes on 07/11/2018.
//  Copyright © 2018 Giuliano Pes. All rights reserved.
//

import Foundation

class PingTest:NSObject, SimplePingDelegate{
    
    var view:ViewController
    
    //var hostName = "192.168.1.1"
    var hostName:String?
    var pinger: SimplePing?
    
    var sendTimer:Timer?
    var sentTime: TimeInterval = 0
    
    var oneHundredPing:[Double]?{
        didSet{
            if oneHundredPing?.count == 100{
                stop()
            }
        }
    }
    
    init(hostAddress: String,view:ViewController){
        self.hostName = hostAddress
        self.oneHundredPing = [Double]()
        self.view = view
    }
    
    func start(){
        self.creaSimplePing()
        self.pinger!.start()
    }
    
    func stop(){
        self.sendTimer!.invalidate()
        self.pinger?.stop()
        self.pinger = nil
        
        let mV = mediaVarianza()
        
        guard let _ = mV.media, let _ = mV.varianza else {return}
        
        print("media: \(mV.media!), varianza: \(mV.varianza!)")
        self.view.updateMediaVarianza(media: mV.media!, varianza: mV.varianza!)
    }
    
    func creaSimplePing(){
        self.pinger = SimplePing(hostName: self.hostName!)
        self.pinger!.delegate = self
        self.pinger!.addressStyle = .icmPv4
    }
    
    //Metodi delegati
    //didStartWithAddress -> Inizia con l'invio del pacchetto
    func simplePing(_ pinger: SimplePing, didStartWithAddress address: Data) {
        
        self.sendPing()
        
        //assert(self.sendTimer == nil)
        //Dopo un secondo, invia un nuovo pacchetto ICMP
        
        //self.sendTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.sendPing), userInfo: nil, repeats: true)
        self.sendTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PingTest.sendPing), userInfo: nil, repeats: true)
    }
    
    @objc func sendPing() {
        //senza dati
        self.pinger?.send(with: nil)
    }
    
    //didSendPacket -> Il pacchetto è stato inviato
    func simplePing(_ pinger: SimplePing, didSendPacket packet: Data, sequenceNumber: UInt16) {
        //print(packet.description) //Stampa 64 bytes
        sentTime = Date().timeIntervalSince1970
        
        //NSLog("#%u sent", sequenceNumber)
    }
    //didReceivePingResponsePacket - > è stato ricevuto il responso del pacchetto
    func simplePing(_ pinger: SimplePing, didReceivePingResponsePacket packet: Data, sequenceNumber: UInt16) {
        
        print(packet.description)
        print("Ping #\(sequenceNumber)")
        let something = ((Date().timeIntervalSince1970 - sentTime).truncatingRemainder(dividingBy: 1)) * 1000
        print("\(something) MS")
        self.view.updateTextViewPingResult(numero: String(sequenceNumber), latenza: String(something))
        
        if sequenceNumber == 0{return}
        
        self.oneHundredPing!.append(something)
        
    }
    
    //Media e varianza
    func mediaVarianza()->(media:Double?,varianza:Double?){
        
        let n:Double = Double(self.oneHundredPing!.count)
        
        if n == 0.0 {return (media:nil,varianza:nil)}
        
        var sommaMedia:Double = 0.0
        var sommaVarianza:Double = 0.0
        
        for ping in self.oneHundredPing!{
            sommaMedia += ping
        }
        let media = sommaMedia/n
        
        for ping in self.oneHundredPing!{
            sommaVarianza += pow(ping-media, 2.0)
        }
        
        let varianza = sommaVarianza/n
        return (media:media,varianza: varianza)
    }
    
}
