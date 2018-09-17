//
//  ManagerViewController.swift
//  Personality Insights
//
//  Created by Piera Marchesini on 16/09/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController {
    let options = ["3 pessoas por time", "4 pessoas por time", "5 pessoas por time"]
    let peoplePicker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ManagerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    
}
