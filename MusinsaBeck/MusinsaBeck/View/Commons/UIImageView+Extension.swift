//
//  UIImageView+Extension.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/17.
//

import UIKit
import os.log

extension UIImageView {
    func setImage(from url: URL?) {
        guard let url = url else {
            return
        }
        
        getImageFromURL(url)
    }
    
    func setImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        getImageFromURL(url)
    }
}

private extension UIImageView {
    func getImageFromURL(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            let httpResponse = response as? HTTPURLResponse
            let urlString = response?.url?.absoluteString ?? "Unknown URL"
            
            if let error = error {
                os_log("[Error] Request image from '\(urlString)'. \(error.localizedDescription)")
                return
            }
            
            if httpResponse?.statusCode != 200 {
                let statusCode = httpResponse?.statusCode == nil ? "Unknown" : "\(httpResponse!.statusCode)"
                os_log("[Warning] Not valid HTTPResponse code(200) from \(urlString), \(statusCode).")
                return
            }
            
            guard let data = data else {
                os_log("[Warning] No data from \(urlString).")
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    self.setNeedsDisplay()
                }
            } else {
                self.image = UIImage(systemName: "nosign")
                os_log("[Warning] UIImage Initializing data from (\(urlString)) failed.")
            }
        }.resume()
    }
}

