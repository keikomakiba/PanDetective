//
//  ViewController.swift
//  PanDetective
//
//  Created by Keiko Makino on 2020/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var basicCard: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    @IBOutlet weak var person5: UIView!
    @IBOutlet weak var person6: UIView!
    @IBOutlet weak var person7: UIView!
    @IBOutlet weak var person8: UIView!
    @IBOutlet weak var person9: UIView!
    @IBOutlet weak var person10: UIView!
    @IBOutlet weak var person11: UIView!
    
    
    var centerOfCard:CGPoint!
    var people = [UIView]()
    var selectedCardCount: Int = 0
    
    let name = ["POINT ET LIGNE","POINT ET LIGNE","Lotus baquette","Lotus baguette","中目トースト","ブレッド＆タパス 沢村 広尾","JEAN FRANCOIS","POINT ET LIGNE","Alaska zwei","SIDEWALK STAND","gentille"]
    var likedName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = basicCard.center
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)
        people.append(person5)
        people.append(person6)
        people.append(person7)
        people.append(person8)
        people.append(person9)
        people.append(person10)
        people.append(person11)
        
    }
    
    func resetCard() {
        basicCard.center = self.centerOfCard
        basicCard.transform = .identity
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushList" {
            let vc = segue.destination as! ListViewController
            vc.likedName = likedName
        }
    }
    @IBAction func likebuttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.resetCard()
            self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x + 500, y: self.people[self.selectedCardCount].center.y)
        })
        likeImageView.alpha = 0
        likedName.append(name[selectedCardCount])
        selectedCardCount += 1
        if selectedCardCount >= people.count {
            performSegue(withIdentifier: "PushList", sender: self)
        }
        
        
    }
    @IBAction func dislikebuttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.resetCard()
            self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 500, y: self.people[self.selectedCardCount].center.y)
        })
        likeImageView.alpha = 0
        selectedCardCount += 1
        if selectedCardCount >= people.count {
            performSegue(withIdentifier: "PushList", sender: self)
        }
    }
    
    
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        people[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        
        
        //角度を変える
        let xFromCenter = card.center.x - view.center.x
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        people[selectedCardCount].transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        
        if xFromCenter > 0 {
            likeImageView.image = #imageLiteral(resourceName: "good")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.red
        }else if xFromCenter < 0 {
            likeImageView.image = #imageLiteral(resourceName: "bad")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.blue
        }
        
        if sender.state == UIGestureRecognizer.State.ended {
            //左に大きくスワイプ
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 300, y: self.people[self.selectedCardCount].center.y)
                })
                likeImageView.alpha = 0
                selectedCardCount += 1
                if selectedCardCount >= people.count {
                    performSegue(withIdentifier: "PushList", sender: self)
                }
                return
            //右に大きくスワイプ
            } else if card.center.x > self.view.frame.width - 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x + 300, y: self.people[self.selectedCardCount].center.y)
                })
                likeImageView.alpha = 0
                likedName.append(name[selectedCardCount])
                selectedCardCount += 1
                if selectedCardCount >= people.count {
                    performSegue(withIdentifier: "PushList", sender: self)
                }
                return
            }
            
            
            //もとに戻る処理
            UIView.animate(withDuration: 0.2, animations: {
                self.resetCard()
                self.people[self.selectedCardCount].center = self.centerOfCard
                self.people[self.selectedCardCount].transform = .identity
            })
            likeImageView.alpha = 0
            
        }
    }
    

}

