//
//  RXAlamVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/19.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift
import RxCocoa
import Alamofire

class RXAlamVC: TBBaseVC {
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        test1()
    }
    //2，使用文件流的形式上传文件
    func test1() {
        //需要上传的文件路径
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
        //服务器路径
        let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
            
        //将文件上传到服务器
        upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL))
            .subscribe(onCompleted: {
                print("上传完毕!")
            })
            .disposed(by: disposeBag)
    }
    //获得上传进度
    func test2() {
        //需要上传的文件路径
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
        //服务器路径
        let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
        
        upload(fileURL!, urlRequest: try! urlRequest(.post,uploadURL)).subscribe(onNext: { (element) in
            
            print("--- 开始上传 ---")
            element.uploadProgress(closure: { (progress) in
                print("当前进度：\(progress.fractionCompleted)")
                print("  已上传载：\(progress.completedUnitCount/1024)KB")
                print("  总大小：\(progress.totalUnitCount/1024)KB")
            })
            
        }, onError: { (error) in
            
        }, onCompleted: {
            print("完成")
        }).disposed(by: disposeBag)
    }
    
  
    func test3() {
        
        //指定下载路径（文件名不变）
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        //需要下载的文件
        let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
        
        //开始下载
        download(URLRequest(url: fileURL), to: destination)
            .subscribe(onNext: { element in
                print("开始下载。")
            }, onError: { error in
                print("下载失败! 失败原因：\(error)")
            }, onCompleted: {
                print("下载完毕!")
            })
            .disposed(by: disposeBag)
    }
    
    //将 logo 图片下载下来，并保存到用户文档目录下的 file1 子目录（ Documnets/file1 目录），文件名改成 myLogo.png。
    func test4() {
        
        //指定下载路径和保存文件名
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("file1/myLogo.png")
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        //需要下载的文件
        let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
        
        //开始下载
        download(URLRequest(url: fileURL), to: destination)
            .subscribe(onNext: { element in
                print("开始下载。")
            }, onError: { error in
                print("下载失败! 失败原因：\(error)")
            }, onCompleted: {
                print("下载完毕!")
            })
            .disposed(by: disposeBag)
    }
    
    func test5() {
        
        //指定下载路径和保存文件名
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("file1/myLogo.png")
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        //需要下载的文件
        let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
        
        //开始下载
        download(URLRequest(url: fileURL), to: destination)
            .subscribe(onNext: { element in
                print("开始下载。")
                element.downloadProgress(closure: { progress in
                    print("当前进度: \(progress.fractionCompleted)")
                    print("  已下载：\(progress.completedUnitCount/1024)KB")
                    print("  总大小：\(progress.totalUnitCount/1024)KB")
                })
            }, onError: { error in
                print("下载失败! 失败原因：\(error)")
            }, onCompleted: {
                print("下载完毕!")
            }).disposed(by: disposeBag)
        
        /*
         //开始下载
         download(URLRequest(url: fileURL), to: destination)
         .map{request in
         //返回一个关于进度的可观察序列
         Observable<Float>.create{observer in
         request.downloadProgress(closure: { (progress) in
         observer.onNext(Float(progress.fractionCompleted))
         if progress.isFinished{
         observer.onCompleted()
         }
         })
         return Disposables.create()
         }
         }
         .flatMap{$0}
         .bind(to: progressView.rx.progress) //将进度绑定UIProgressView上
         .disposed(by: disposeBag)
         */
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
