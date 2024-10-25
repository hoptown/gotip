//
//  SettingsView.swift
//  Go Tip -Swift
//
//  Created by Lawrence Lovelace on 3/10/20.
//  Copyright © 2020 Pledge Geek. All rights reserved.
//

import UIKit

class SettingsView: UIViewController {

  @IBOutlet var labelColorScheme: UILabel!
  @IBOutlet var buttonColorScheme: UIButton!
  @IBOutlet var labelAbout: UILabel!
    @IBOutlet var labelRoundUp: UILabel!
    @IBOutlet var labelTipPercent: UILabel!
  
  let userDefaults = UserDefaults.standard
  var colorScheme = ""
  let light_GreenColor = UIColor(red: 82/255.0, green: 184/255.0, blue: 131/255.0, alpha: 1.0)// UIColor.green
  let light_BrownColor = UIColor(red: 142/255.0, green: 128/255.0, blue: 113/255.0, alpha: 1.0)
  let dark_GreenColor = UIColor(red: 22/255.0, green: 160/255.0, blue: 133/255.0, alpha: 1.0)
  let dark_grayColor = UIColor.gray
  
  let darkerGrayColor = UIColor(red: 61/255.0, green: 61/255.0, blue: 61/255.0, alpha: 1.0)
  let dark_blackColor = UIColor(red: 41/255.0, green: 41/255.0, blue: 41/255.0, alpha: 1.0)
  
  let blackColor = UIColor.black
  let whiteColor = UIColor.white
  
  

  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      colorScheme = userDefaults.string(forKey: COLOR_SCHEME) ?? DARK_GREEN // other options is light-green
      title = "Settings"
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupView()
  }
  
  func setupView() {
    
    buttonColorScheme.layer.cornerRadius = 10; // this value vary as per your desire
    buttonColorScheme.clipsToBounds = true
    buttonColorScheme.setTitle("", for: .normal)
    
    if colorScheme == DARK_GREEN {
      
      self.view.backgroundColor = darkerGrayColor
      labelColorScheme.textColor = whiteColor
//      buttonColorScheme.setTitleColor(whiteColor, for: .normal)
      buttonColorScheme.backgroundColor = UIColor.green
      labelAbout.textColor = UIColor.green
        labelRoundUp.textColor = UIColor.green
        labelTipPercent.textColor = UIColor.green
    }
    else {
      
      self.view.backgroundColor = whiteColor
      labelColorScheme.textColor = light_GreenColor
      buttonColorScheme.backgroundColor = light_GreenColor
      labelAbout.textColor = light_GreenColor
        labelRoundUp.textColor = light_GreenColor
        labelTipPercent.textColor = light_GreenColor
    }
            
        
    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
    let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
    
    labelAbout.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
    labelAbout.text = "Developed by Triple-L\n\n"
    labelAbout.text! += "(version \(appVersion ?? ""), build \(appBuild ?? ""))"
  }

  @IBAction func switchColorSchemes() {
    
    if colorScheme == LIGHT_GREEN {
      colorScheme = DARK_GREEN
      userDefaults.set(DARK_GREEN, forKey: COLOR_SCHEME)
      self.setupColorScheme()
    }
    else
    {
      colorScheme = LIGHT_GREEN
      userDefaults.set(LIGHT_GREEN, forKey: COLOR_SCHEME)
      self.setupColorScheme()
    }
  }
  
  func setupColorScheme() {
    
    if colorScheme == DARK_GREEN {
      
      self.view.backgroundColor = darkerGrayColor
      labelColorScheme.textColor = whiteColor
      buttonColorScheme.backgroundColor = UIColor.green
      labelAbout.textColor = UIColor.green
        labelRoundUp.textColor = UIColor.green
        labelTipPercent.textColor = UIColor.green
      
      self.view.backgroundColor = darkerGrayColor
      self.navigationController?.navigationBar.barTintColor = dark_blackColor
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.green]
      self.navigationController?.navigationBar.tintColor = UIColor.white
      
//      let segmentTextColor = UIColor.green
//      UISegmentedControl.appearance().setTitleTextAttributes([
//      NSAttributedString.Key.foregroundColor: segmentTextColor
//      ], for: .normal)
    }
      
    else if colorScheme == LIGHT_GREEN {
      
      self.view.backgroundColor = whiteColor
      labelColorScheme.textColor = light_GreenColor
      buttonColorScheme.backgroundColor = light_GreenColor
      labelAbout.textColor = light_GreenColor
        labelRoundUp.textColor = light_GreenColor
        labelTipPercent.textColor = light_GreenColor
      
      self.view.backgroundColor = whiteColor
      self.navigationController?.navigationBar.barTintColor = light_GreenColor
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white // UIColor.black
      
     /* let segmentTextColor = UIColor.white
      
      UISegmentedControl.appearance().setTitleTextAttributes([
           NSAttributedString.Key.foregroundColor: segmentTextColor
           ], for: .selected)
      
      UISegmentedControl.appearance().setTitleTextAttributes([
        NSAttributedString.Key.foregroundColor: UIColor.lightGray
      ], for: .normal)*/
    }
  }
  
  func dismissThisView() {
    
    dismiss(animated: true, completion: nil)
  }

}
