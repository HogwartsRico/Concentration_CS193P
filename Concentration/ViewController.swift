//
//  ViewController.swift
//  Concentration
//
//  Created by rico on 2019/4/6.
//  Copyright © 2019 Rico. All rights reserved.
//这是个ViewController,MVC中的Controller

import UIKit

class ViewController: UIViewController {//它继承了UIVIewController

    /**     这里为什么要懒加载game？因为初始化game的时候要用到cardButtons,而初始化game的时候cardButtons在ViewController中可能还未初始化，所以需要懒加载game变量
    */
    lazy var game:Concentration = Concentration(numberOfPairsOfCards: cardButtons.count/2);//懒初始化 参数是卡牌对的数量,所以是按钮数除以2  Controller->Model
    
     @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    //var emojiChoices:Array<String>=["🎃","👻","🎃","👻"];
    private var emojiChoices = ["👻","🎃","😈","💀","🤡","🤖","🦇","👽"]
    //private var emojiChoices = "👻🎃😈💀🤡🤖🦇👽"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //var flipCount:Int=0;//这个属性(字段)用于记录你翻了多少次，次数越少越好  Swift有类型推导，所以不用写int
    var flipCount=0  {//Swift有类型推导，所以不用写int
        didSet{//每次flipCount改变之后都会调用didSet            
            flipCountLabel.text="Flips:\(flipCount)";
        }
    };
    /**
     @IBAction的作用就是让左边圆圈显示在上面
     func表示它是一个function，
     然后参数类型是UIButton ，参数名和类型用英文冒号分隔
     _ sender是参数的名字
     swift和其他语言不一样，有一个实参标签，一个是形参标签 _表示没有实参标签，也即是像Java那样的
     */
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount+=1;
        if let cardNumber=cardButtons.firstIndex(of: sender){//找出点击的这个button是第几个
            //print("cardNumber:\(cardNumber)")
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender) 不再在controller中执行逻辑，而是调用model的相应行为
            game.chooseCard(at: cardNumber);
            updateViewByModel();
        }else{
             print("choose card is not in buttons")
        }
    }
    
    //根据Model当前的状态刷新Button的翻转，是否消失(匹配)等
    func updateViewByModel(){
        //for buttonIndex in 0..<cardButtons.count {
        for buttonIndex in cardButtons.indices {//indices是数组中的一个变量,其类型是 Range<Int> ,由数组所有索引组成的可数区间
            let theButton = cardButtons[buttonIndex];//获取这个按钮
            let card = game.cards[buttonIndex];//获取这个按钮对应的model,里面存储着它的是否朝上，是否配对等信息
            if (card.isFaceUp){//如果是正面朝上的(有图案的那一面)
                theButton.setTitle(getEmoji(byCard:card), for: UIControl.State.normal);
                theButton.backgroundColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
            } else {//背面朝上
                theButton.setTitle("", for: UIControl.State.normal);
                theButton.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5309994614, blue: 0.3670836627, alpha: 1) ;//如果是匹配的，那么变透明  这就要保证卡牌如果匹配后一定要正面朝下，背面朝上，因为正面朝上是没有是否匹配判断的
            }
        }
    }
    
    //根据card获取emoji
    func getEmoji(byCard card : Card) -> String {
        return "?";//todo
    }
   
   
    
    
    /*
     经过MVC改造后就不再在Controller中对V进行操作了,所以此方法废弃了
     实参标签为withEmoji,形参标签为emoji,类型是String
     实参标签为on,形参标签为button,类型是UIButton
    func flipCard(withEmoji emoji:String ,on button:UIButton){
        print("filiCard with emoji \(emoji)")
        if (button.currentTitle==emoji){
            button.setTitle("", for: UIControl.State.normal);
            button.backgroundColor=#colorLiteral(red: 1, green: 0.5309994614, blue: 0.3670836627, alpha: 1);
        }else{
            button.setTitle(emoji, for: UIControl.State.normal);
            button.backgroundColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
        }
    }*/
    
}

