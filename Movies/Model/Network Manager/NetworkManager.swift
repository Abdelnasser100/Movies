//
//  NetworkManager.swift
//  Movies
//
//  Created by Abdelnasser on 31/08/2021.
//

import Foundation
import Alamofire


class NetworkManager {
    
    static let shared = NetworkManager()
    private init(){}
    let manager = NetworkReachabilityManager(host: "www.apple.com")

    var isReachable = false
    
    
    func startMonitoring(){
        self.manager?.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: { networkStatus in
            if networkStatus == .reachable(.cellular) || networkStatus == .reachable(.ethernetOrWiFi){
                self.isReachable = true
            }else{
                self.isReachable = false
            }
        })
    }
    func isConnected() -> Bool{
        return self.isReachable
    }
    
}
