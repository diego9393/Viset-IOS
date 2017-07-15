//
//  Inicio.swift
//  VisetIOS
//
//  Created by Diego on 30/1/17.
//  Copyright © 2017 Diego. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class Inicio: UIViewController
{
    @IBOutlet weak var EstadoInternet: UILabel!
    @IBOutlet weak var EstadoServidor: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        estadoServer()
        estadoInternet()
        
    }
    
    func estadoServer(){
        let url = URL(string: "https://viset.varraysoftware.com")
        let task = URLSession.shared.dataTask(with: url!) { _, response, _ in
            if let httpResponse = response as? HTTPURLResponse {
                let EstadoServerSTR = String(httpResponse.statusCode);
                if(EstadoServerSTR == "200")
                {
                    if (self.estadoInternet() != "Error")
                    {
                        self.EstadoServidor.text = "Servidor online";
                    }
                    else
                    {
                        self.EstadoServidor.text = "No hay internet";
                    }
                }
                else
                {
                    self.EstadoServidor.text = "Error: " + EstadoServerSTR;
                }
            }
        }
        
        task.resume()
    }
    
    func estadoInternet() -> String {
        
        var estadoInt = "Error";
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            estadoInt = "Error";
            self.EstadoInternet.text = estadoInt;
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        let estado = isReachable && !needsConnection;
        if(estado == true)
        {
            estadoInt = "Conectado a internet";
            self.EstadoInternet.text = estadoInt;
        }
        else
        {
            estadoInt = "Error";
            self.EstadoInternet.text = estadoInt;
        }
        
        return estadoInt;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
