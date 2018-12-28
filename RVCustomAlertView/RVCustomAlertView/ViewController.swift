//
//  ViewController.swift
//  RVCustomAlertView
//
//  Created by 百年 on 2018/12/26.
//  Copyright © 2018年 百年. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //g1()
        //g2()
        //g3
        //g4()
        //g5()
        //g6()
        g7()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showAlert(_ sender: UIButton) {
        let alert = RVAlertView()
        alert.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
/*
 * GCD FUNC
 */
extension ViewController{
   //异步执行 -> 主线程
    func g1(){
        print("主线程 = \(Thread.current)")
        DispatchQueue.global().async {
            print("目前线程  = \(Thread.current)")
            DispatchQueue.main.async {
                print("回到主线程 = \(Thread.current)")
            }
        }
    }
    //创建一个指定qos的queue
    func g2(){
        print("开始")
        DispatchQueue(label: "g2").sync {
            print("同步线程")
        }
        print("结束")
    }
    //DispatchGroup
    func g3(){
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        group.enter()
        queue.async(group: group) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                print("task one")
                group.leave()
            })
        }
        
        group.enter()
        queue.async(group: group) {
           print("task two")
            group.leave()
        }
        
        group.notify(queue: queue) {
            print("all end")
        }
        
    }
//semaphore
    func g4(){
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 0)
        queue.async(group: group) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                semaphore.signal()
                print("task one")
            })
            semaphore.wait()
        }
        queue.async(group: group) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: {
                semaphore.signal()
                print("task two")
            })
            semaphore.wait()
        }
        queue.async(group: group) {
           print("task three")
        }
        group.notify(queue: queue) {
            print("all task")
        }
    }
    //重复执行同一个任务
    func g5(){
        DispatchQueue.concurrentPerform(iterations: 5) { (index) in
            print("\(index)")
        }
    }
    //定时器
    func g6(){
        var timeCount = 60
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: DispatchTime.now(), repeating:.seconds(1))
        timer.setEventHandler {
            timeCount -= 1
            if timeCount <= 0{timer.cancel()}
            DispatchQueue.main.async {
                print("\(timeCount)")
            }
        }
        timer.resume()
    }
    
    //dispatchworkitem
    func g7(){
        let queue = DispatchQueue(label: "g7", attributes: DispatchQueue.Attributes.concurrent)
        let workItem = DispatchWorkItem  {
            print("done")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            queue.async(execute: workItem)
        }
        workItem.cancel()
    }
    
    
}

