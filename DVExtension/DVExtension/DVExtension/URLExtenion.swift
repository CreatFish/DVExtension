//
//  URLExtenion.swift
//  Amall
//  URL扩展
//  Created by David Yu on 2018/1/11.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import UIKit
import AVKit

public extension URL {
    
    // MARK:- 获取url中的参数
    public func getArg(_ k:String)->String{
        var substr:String?
        let sarr = self.query?.split("?")
        if (sarr?.count ?? 0) <= 1{
            if (self.query?.has(k) != nil) {
                let p = "(?<=" + k + "\\=)[^&]+";
                let range = self.query?.range(of: p, options: NSString.CompareOptions.regularExpression, range: nil, locale: nil)
                if range != nil {
                    substr = String((self.query ?? "")[range!])
                }
            }
        } else {
            for parameter in self.query!.components(separatedBy: "&") {
                let parts = parameter.components(separatedBy: "=")
                if parts.count > 1{
                    let key = (parts[0] as NSString).replacingPercentEscapes(using: String.Encoding.utf8.rawValue)
                    let value = (parts[1] as NSString).replacingPercentEscapes(using: String.Encoding.utf8.rawValue)
                    if key != nil && value != nil && key == k{
                        substr = value
                    }
                }
            }
        }
        if substr == nil {
            substr = ""
        }
        return substr!
    }
    
    // MARK:- 获取网络视频的第一帧图片
    public func firstFrameWithVideoURL(imgBlock : @escaping(UIImage?) -> ()) {
        DispatchQueue.global().async {
            var img = UIImage()
            let number = NSNumber.init(value: false)
            let opts : [String : NSNumber] = [AVURLAssetPreferPreciseDurationAndTimingKey : number]
            let asset = AVURLAsset.init(url: self, options: opts)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform=true
            let time = CMTimeMakeWithSeconds(0.0,preferredTimescale: 600)
            var actualTime:CMTime=CMTimeMake(value: 0,timescale: 0)
            var image:CGImage?
            do {
                image = try generator.copyCGImage(at: time, actualTime: &actualTime)
                //需要主线程执行的代码
                DispatchQueue.main.async {
                    img = UIImage(cgImage: image!)
                    imgBlock(img)
                }
            } catch {
                DispatchQueue.main.async {
                    img = UIImage(cgImage: image!)
                    imgBlock(nil)
                }
            }
        }
    }
    
}
