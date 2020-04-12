//
//  ViewController.swift
//  DismissKeyboardUITextView
//
//  Created by ProgrammingWithSwift on 2020/04/11.
//  Copyright © 2020 ProgrammingWithSwift. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell"
        
        let cellTextField = UITextField(frame: CGRect(x: 60,
                                                      y: 10,
                                                      width: UIScreen.main.bounds.size.width - 80,
                                                      height: 25))
        cellTextField.layer.borderColor = UIColor.gray.cgColor
        cellTextField.layer.borderWidth = 1
        cellTextField.delegate = self
        
        cell.addSubview(cellTextField)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the below line if you want to test the tableview
//        self.useTableView()
        
        // Uncomment the below line if you want to test the non tableview
        self.useNonTableView()
        
        /*
         Tap Gesture to remove keyboard
         */
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func useTableView() {
        let tableview = UITableView(frame: self.view.bounds)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.keyboardDismissMode = .onDrag

        self.view.addSubview(tableview)
    }
    
    private func useNonTableView() {
        let textField = UITextField(frame: CGRect(x: 20,
                                                  y: 50,
                                                  width: UIScreen.main.bounds.size.width - 40,
                                                  height: 44))
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.delegate = self

        let button = UIButton(frame: CGRect(x: 20,
                                            y: 100,
                                            width: UIScreen.main.bounds.size.width - 40,
                                            height: 44))
        button.backgroundColor = .black
        button.setTitle("test button", for: .normal)
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)

        self.view.addSubview(textField)
        self.view.addSubview(button)
    }
    
    // Used to ensure that the button is being clicked.
    @objc
    private func buttonAction() {
        print("button action")
    }
    
    /*
     1. This does not work when tapping on a button
     2. This does not work on tableview
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches,
                           with: event)
        self.view.endEditing(true)
        print("touches began")
    }
    
    /*
     This only works when tapping the return key on keyboard
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc
    private func hideKeyboard() {
        self.view.endEditing(true)
        print("hide keyboard")
    }
}
