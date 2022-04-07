//
//  CountDownTimerViewController.swift
//  WillDiary
//
//  Created by 澤田世那 on 2022/03/31.
//

import UIKit

class CountDownTimerViewController: UIViewController {
    
    var dyingDate: Date = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let setPickerText = UserDefaults.standard.string(forKey: "setPickerLabel") {
//            self.datePickerLabel.text = setPickerText
//        }
        Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.viewDidLoadTimerCounter),
                                     userInfo: nil,
                                     repeats: true)
    }
//    @IBOutlet weak var datePickerLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    
    @objc func viewDidLoadTimerCounter() {
            
        // UserDefaultsで保存したDatePickerの設定時刻を、このメソッドが実行されるときに呼び出して、新たな定数に代入し、その値をアンラップしてから使用する。
        let value = UserDefaults.standard.object(forKey: "setPicker") as? Date
            
        guard let didValue = value else {
            return
        }
       
        countDownLabel.text = timerFunction(setDate: didValue)
    }
    
    @IBAction func exitFromEditByBackSegue(segue: UIStoryboardSegue) {
        
        if let add = segue.source as? EditingTimerViewController {
            dyingDate = add.dyingDatePicker.date
//            let dateFormatter: DateFormatter = {
//                let formatter = DateFormatter()
//                formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
//                return formatter
//            }()
//            datePickerLabel.text = "\(dateFormatter.string(from: dyingDate)) まで"
//            UserDefaults.standard.set(datePickerLabel.text, forKey: "setPickerLabel")
            
            UserDefaults.standard.set(dyingDate, forKey: "setPicker")
            // settings.synchronize()
            
            // タイマーをスタート
            Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                 selector: #selector(timerCounter),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
        
    @objc func timerCounter() {
        let settingDate = dyingDate
        countDownLabel.text = timerFunction(setDate: settingDate)
    }
        
    func timerFunction(setDate: Date) -> String {
            
        let nowDate = Date() // 現在時刻
        let calendar = Calendar(identifier: .japanese) // 日本設定のカレンダーを指定
        // 現在時刻と設定時刻の差を算出
        let timerValue = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nowDate, to: setDate)
        return String(format: "残り"+"%2d年 %2dヶ月 %2d日 %2d時間 %2d分 %2d秒",
                        timerValue.year!,
                        timerValue.month!,
                        timerValue.day!,
                        timerValue.hour!,
                        timerValue.minute!,
                        timerValue.second!)
    }
}
