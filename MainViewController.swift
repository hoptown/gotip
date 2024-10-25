//  MainViewController
//  Go Tip -Swift
//
//  Created by Lawrence Lovelace on 3/10/20 - originally created on 11/6/11
//  Copyright © 2020 Pledge Geek. All rights reserved.
//
// a good source: https://www.swiftbysundell.com/articles/formatting-numbers-in-swift/

import UIKit

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
  
  @IBOutlet var digits: [UIButton]!
  
  @IBOutlet var viewIndividual: UIView!
  @IBOutlet var viewAmount: UIView!
  
  @IBOutlet var labelAmountHeader: UILabel!
  @IBOutlet var viewPicker1: UIView!
  @IBOutlet var viewPicker2: UIView!
  
  @IBOutlet var viewGroup: UIView!
  
  @IBOutlet var lblIndividualAmount: UILabel!
  @IBOutlet var lblGroupAmount: UILabel!
  @IBOutlet var lblIndividualTipTotal: UILabel!
  @IBOutlet var lblGroupTipTotal: UILabel!
  @IBOutlet var theDate: UILabel!
  
  @IBOutlet var txtBillAmount: UITextField!
  
  @IBOutlet var pickerPercentage: UIPickerView!
  @IBOutlet var pickerNumberOfPeople: UIPickerView!
  
  @IBOutlet var btnDel: UIButton!
  @IBOutlet var btnClear: UIButton!
  @IBOutlet var btn0: UIButton!
  @IBOutlet var btn1: UIButton!
  @IBOutlet var btn2: UIButton!
  @IBOutlet var btn3: UIButton!
  @IBOutlet var btn4: UIButton!
  @IBOutlet var btn5: UIButton!
  @IBOutlet var btn6: UIButton!
  @IBOutlet var btn7: UIButton!
  @IBOutlet var btn8: UIButton!
  @IBOutlet var btn9: UIButton!
  @IBOutlet var personImage: UIImageView!
  @IBOutlet var groupImage: UIImageView!
  @IBOutlet var viewNumberpad: UIView!
  
  let settings = UserDefaults.standard
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  
  var arrayForPercentages: [Int] = []
  var arrayForNumberOfPeople: [Int] = []
//  var currentAmount = "0.00" //Current is the Field that User Enters
    var currentAmountStr = ""
  var billAmount: Double = 0
  var individualTipAmount: Double = 0
  var groupTipAmount: Double = 0
  var groupGrandTotal: Double = 0
  var individualAmount: Double = 0
  
  
  // MARK: VIEW
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addMenuBarButton()
    self.title = "Go Tip!"
    createDataForView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    addDateToNavigationBar()
    setupHomeViewColorScheme()
  }

  // MARK: - PICKER DELEGATE
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    if pickerView == pickerNumberOfPeople {
      return arrayForNumberOfPeople.count
    }
    else {
      return arrayForPercentages.count
    }
  }
 
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return 30
    }
    else {
      return 55
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
   
    var titleForRow = ""
    if pickerView == pickerPercentage {
      titleForRow = "\(arrayForPercentages[row])%"
    }
    else {
      titleForRow = "\(arrayForNumberOfPeople[row])"
    }
    
    var attrString = NSAttributedString(string: titleForRow, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
    
    let colorScheme = settings.string(forKey: COLOR_SCHEME)
    if colorScheme == DARK_GREEN
    {
      attrString = NSAttributedString(string: titleForRow, attributes: [NSAttributedString.Key.foregroundColor : UIColor.green])
    }
    else
    {
      let myLightGreen = UIColor(red: 82/255.0, green: 184/255.0, blue: 131/255.0, alpha: 1.0)
      attrString = NSAttributedString(string: titleForRow, attributes: [NSAttributedString.Key.foregroundColor : myLightGreen])
    }
    
    return attrString
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    calculateAmountsTaxTip()
    saveData()
  }
  
  // MARK: - IBACTIONS
    @IBAction func buttonDigitPressed(_ button: UIButton!) {
        
        let digit = button.tag
        print("digit is  \(digit)")
        /*if lblIndividualAmount.text!.count < 13 {
         if currentAmount <= 0 {
         currentAmount = digit
         let amount = Double(currentAmount)
         billAmount = amount * 0.01
         print(billAmount)
         }
         else {
         let strAmount = ("\(Int(currentAmount))\(digit)")
         currentAmount = Double(strAmount) ?? 0.0
         let amount = Double(currentAmount)
         billAmount = amount * 0.01
         print(billAmount)
         }
         }*/
        
        if currentAmountStr.count >= 14 {
            alertMaxDigits()
        }
        else if digit == 0 && billAmount == 0 {
            // no need to calculate 0 with another 0. It's still 0
        }
        else if txtBillAmount.text!.count < 13 {
            print("current : \(currentAmountStr)")
            currentAmountStr = "\(currentAmountStr)" + "\(digit)"
            print("after : \(currentAmountStr)")
//            let amount = Double(currentAmountStr) ?? 0.0
            billAmount = Double(currentAmountStr)! * 0.01
            print("after tapping digit, new bill amount:  \(billAmount)")
            
            calculateAmountsTaxTip()
        }
    }
  
    @IBAction func delButton(_ button: UIButton!) {
        
        var amount = Double(0)
        if (currentAmountStr.isEmpty == false)
        {
            currentAmountStr.removeLast()
            amount = Double(currentAmountStr) ?? 0.0
        }
        else if currentAmountStr.count == 1 {
            currentAmountStr = ""
        }
        print(currentAmountStr)
        billAmount = amount * 0.01
        print(billAmount)
        calculateAmountsTaxTip()
        
        /*   var strDel = "\(txtBillAmount.text?.dropLast() ?? "0")"
         strDel = strDel.replacingOccurrences(of: "$", with: "") // remove the currency signs
         print("new string:  \(strDel)")
         currentAmount = Double(strDel) ?? 0.0
         print("new current amount:  \(currentAmount)")
         billAmount = currentAmount // * 0.01
         
         calculateAmountsTaxTip()*/
    }
  
    @IBAction func clearButton() {
        
        billAmount = 0
        groupGrandTotal = 0
        individualAmount = 0
        individualTipAmount = 0
        groupTipAmount = 0
        currentAmountStr = ""
        updateLabels()
    }

  // MARK: - TEXT FIELD DELEGATE
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool { // return NO to disallow editing.
    return false // Hide both keyboard and blinking cursor when user touches text field
  }

  func textFieldDidBeginEditing(_ textField: UITextField) { // became first responder
    textField.resignFirstResponder()
  }
 
  
  // MARK: - HELPERS
  func createDataForView() {
    
    //Picker View Initialization. Up to 50% tip
    for n in 0...50 {
      arrayForPercentages.append(n)
    }
    
    for n in 1...20 {
      arrayForNumberOfPeople.append(n)
    }
    
    billAmount = 0
      groupGrandTotal = 0
    individualAmount = 0
    currentAmountStr = ""
    
    getSettings()
    updateLabels()
  }
  
  func getSettings() {
    
    let currentTipRate = settings.integer(forKey: DEFAULT_TIP)
    let currentSplit = settings.integer(forKey: PEOPLE)
    
    pickerPercentage.selectRow(currentTipRate, inComponent: 0, animated: false)
    pickerNumberOfPeople.selectRow(currentSplit - 1, inComponent: 0, animated: false)
  }
  
  func saveData() {
    
    // store the screen data for the return
    let var1 = pickerPercentage.selectedRow(inComponent: 0)
    let var2 = pickerNumberOfPeople.selectedRow(inComponent: 0) + 1
      
    settings.set(var1, forKey: DEFAULT_TIP)
    settings.set(var2, forKey: PEOPLE)
  }
  
    func calculateAmountsTaxTip() {
        
        let selectedTip = Double(arrayForPercentages[pickerPercentage.selectedRow(inComponent: 0)])
        let selectedNumberOfPeople = Double(arrayForNumberOfPeople[pickerNumberOfPeople.selectedRow(inComponent: 0)])
        
        if billAmount > 0
        {
            if selectedTip > 0 {
                let tipPercentage = selectedTip/100
                groupTipAmount = billAmount * tipPercentage
                print(groupTipAmount)
                individualTipAmount = groupTipAmount/selectedNumberOfPeople
                print(individualTipAmount)
            }
            else {
                individualTipAmount = 0
                groupTipAmount = 0
            }
    
            
            // Calculate Group and Individual Total Bill
            groupGrandTotal = billAmount + groupTipAmount
            print(groupGrandTotal)
            individualAmount = (groupGrandTotal/selectedNumberOfPeople) // + individualTipAmount
            print(individualAmount)
            print("after new calculations")
            print(currentAmountStr)
            print(billAmount)
        }
        else {
            individualTipAmount = 0
            individualAmount = 0
            groupTipAmount = 0
            groupGrandTotal = 0
        }
        
        updateLabels()
    }
    
    func updateLabels() {
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        format.usesGroupingSeparator = true
        
        lblIndividualAmount.text = format.string(from: NSNumber(value: individualAmount))
        print(lblIndividualAmount.text!)
        let strIndividualTipAmount = "includes \(format.string(from: NSNumber(value: individualTipAmount)) ?? "") tip"
        lblIndividualTipTotal.text = strIndividualTipAmount
        
        lblGroupAmount.text = format.string(from: NSNumber(value: groupGrandTotal))
        let strGroupTipAmount = "includes \(format.string(from: NSNumber(value: groupTipAmount)) ?? "") tip"
        lblGroupTipTotal.text = strGroupTipAmount
        
        txtBillAmount.text = format.string(from: NSNumber(value: billAmount))
    }
    
    
    
    // MARK: - VIEW, NAV, AND INTERFACE
  
  func addMenuBarButton() {
   
    let settingsBtn = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(goToSettings))
    settingsBtn.accessibilityLabel = "settings"
    settingsBtn.accessibilityHint = "double tap to open the app's settings"
    self.navigationItem.rightBarButtonItem = settingsBtn
  }
  
  func addDateToNavigationBar() {
    
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "E, d MMM"
    let dateDisplay = UIBarButtonItem(title: formatter.string(from: date), style: .plain, target: self, action: nil)
    self.navigationItem.leftBarButtonItem = dateDisplay
  }
  
  @objc func goToSettings() {
    
    performSegue(withIdentifier: "showSettings", sender: nil)
  }
  
  // MARK: - COLOR SCHEME
  func setupHomeViewColorScheme() {
    
    let colorScheme = settings.string(forKey: COLOR_SCHEME)
    
    if colorScheme == DARK_GREEN
    {
      let darkGrayColor = UIColor(red: 61/255.0, green: 61/255.0, blue: 61/255.0, alpha: 1.0)
      let darkerGrayColor = UIColor(red: 41/255.0, green: 41/255.0, blue: 41/255.0, alpha: 1.0)
      let greenColor = UIColor.green
      let whiteColor = UIColor.white
      
      self.navigationController?.navigationBar.barTintColor = darkGrayColor
      self.view.backgroundColor = darkGrayColor
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.green]
      self.navigationController?.navigationBar.tintColor = UIColor.white // buttons
      
      lblIndividualAmount.textColor = greenColor
      lblIndividualTipTotal.textColor = greenColor
      
      lblGroupAmount.textColor = whiteColor
      lblGroupTipTotal.textColor = whiteColor
      
      txtBillAmount.textColor = whiteColor
      labelAmountHeader.textColor = whiteColor
      
      viewPicker1.backgroundColor = UIColor.clear
      viewPicker2.backgroundColor = UIColor.clear
      
      viewAmount.backgroundColor = darkerGrayColor
      viewIndividual.backgroundColor = darkerGrayColor
      viewGroup.backgroundColor = darkerGrayColor
      
      personImage.image = UIImage(named: "individual_icon_dark")
      groupImage.image = UIImage(named: "group_icon_dark")
      
      for button in digits {
        button.setTitleColor(darkGrayColor, for: .normal)
        button.backgroundColor = greenColor
      }
    }
      
    else
    {
      let myLightGreen = UIColor(red: 82/255.0, green: 184/255.0, blue: 131/255.0, alpha: 1.0)
      let lightGrayColor = UIColor.lightGray
      let myDarkGrayColor = UIColor(red: 69/255.0, green: 114/255.0, blue: 100/255.0, alpha: 1.0)
      let numberBackgroundColor = UIColor(red: 236/255.0, green: 235/255.0, blue: 241/255.0, alpha: 1.0)
      let viewsBackgroundColor = UIColor(red: 248/255.0, green: 243/255.0, blue: 240/255.0, alpha: 1.0)
      let blackColor = UIColor.black
      let whiteColor = UIColor.white

      self.navigationController?.navigationBar.barTintColor = myLightGreen // bar color
      self.view.backgroundColor = whiteColor
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : whiteColor] // title color
        self.navigationController?.navigationBar.tintColor = .white // blackColor // buttons
      
      lblIndividualAmount.textColor = myLightGreen
      lblIndividualTipTotal.textColor = lightGrayColor
      viewIndividual.backgroundColor = viewsBackgroundColor
      
      lblGroupAmount.textColor = myLightGreen
      viewGroup.backgroundColor = viewsBackgroundColor
      lblGroupTipTotal.textColor = lightGrayColor
      
      viewPicker1.backgroundColor = UIColor.clear
      viewPicker2.backgroundColor = UIColor.clear
      
      viewAmount.backgroundColor = myLightGreen
      txtBillAmount.textColor = myDarkGrayColor
      labelAmountHeader.textColor = myDarkGrayColor
      
      personImage.image = UIImage(named: "individual_icon_light")
      groupImage.image = UIImage(named: "group_icon_light")
      
      for button in digits {
        button.setTitleColor(blackColor, for: .normal)
        button.backgroundColor = numberBackgroundColor
      }
    }
    
    pickerPercentage.reloadComponent(0)
    pickerNumberOfPeople.reloadComponent(0)
  }
  
  func alertMaxDigits() {
    
    let alertController = UIAlertController(title: "Check Your Amount", message: "Maximum 13 digits are allowed", preferredStyle: .alert)
    
    let save = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
      
    })
    
    alertController.addAction(save)
    self.present(alertController, animated: true)
  }
  
}
