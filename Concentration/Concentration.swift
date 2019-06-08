//
//  Concentration.swift
//  Concentration
//
//  Created by rico on 2019/4/8.
//  Copyright © 2019 Rico. All rights reserved.
//这也是一个Model Card也是一个Model
//这个类是这个游戏中最重要的一个类，声明了它用到的一些Model，api方法等 

import Foundation
class Concentration{
    var cards=Array<Card>();//var cards=[Card]();//这样也可以
    
    func chooseCard(at index:Int) {//参数是卡片的数组中的位置索引
        print("cardNumber:\(index)")
        if cards[index].isFaceUp {//如果是正面，那就改成反面,反之，亦然
            cards[index].isFaceUp = false;
        } else {
            cards[index].isFaceUp = true;
        }
    }
    
    init(numberOfPairsOfCards:Int){//构造函数 参数为卡牌的数量 for循环将Card实例化
        //for identifier in 0..<numberOfPairsOfCards{//CountableRange 从0开始，但是不包括numberOfPairsOfCards
        for identifier in 1...numberOfPairsOfCards{//CountableRange 从1开始，包括numberOfPairsOfCards
            let card=Card();
            let matchCard=card;//由于结构体的赋值是值拷贝的，所以有了一个副本。 因为卡牌肯定是有2个一模一样的
            cards.append(card);
            cards.append(matchCard);//也可以写成cards.append(card);//因为是值拷贝，不是引用拷贝 而且这里的2个card的identifier是相同的,这样保证了他们的图案是相同的
            
            //cards+=[card,card]; 也可以写成这样
        }
        //todo:洗牌,如果不洗牌将会都是顺序的，失去了游戏性
    }
}
