//
//  CardsViewController.swift
//  FindSitter
//
//  Created by Siddharth Sharma on 4/20/15.
//  Copyright (c) 2015 Siddharth Sharma. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, SwipeViewDelegate {
  
  struct Card {
    let cardView: CardView
    let swipeView: SwipeView
  }
  
  let frontCardTopMargin: CGFloat = 0
  let backCardTopMargin: CGFloat = 10
  
  @IBOutlet weak var cardStackView: UIView!
  
  var backCard: Card?
  var frontCard: Card?
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationItem.titleView = UIImageView(image: UIImage(named: "nav-header"))
    let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToProfile:")
    navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    cardStackView.backgroundColor = UIColor.clearColor()
    
    backCard = createCard(backCardTopMargin)
    cardStackView.addSubview(backCard!.swipeView)
    
    frontCard = createCard(frontCardTopMargin)
    cardStackView.addSubview(frontCard!.swipeView)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func createCardFrame(topMargin: CGFloat) -> CGRect {
    return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
  }
  
  private func createCard(topMargin: CGFloat) -> Card {
    let cardView = CardView()
    let swipeView = SwipeView(frame: createCardFrame(topMargin))
    swipeView.delegate = self;
    swipeView.innerView = cardView
    return Card(cardView: cardView, swipeView: swipeView)
  }
  
  func goToProfile(button: UIBarButtonItem) {
    pageController.goToPreviousVC()
  }
  
  // MARK: - SwipeView Delegates
  
  func swipedLeft() {
    println("Left")
    if let fc = frontCard {
      fc.swipeView.removeFromSuperview()
    }
  }
  
  func swipedRight() {
    println("Right")
    if let fc = frontCard {
      fc.swipeView.removeFromSuperview()
    }
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
