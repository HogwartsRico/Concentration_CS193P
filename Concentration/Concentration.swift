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
    
    var indexOfOneAndOnlyFaceUpCard: Int?; //当前有且仅有一张朝上时这张卡片的索引值。 如果没有任何卡片朝上或者有2张卡片朝上，那么这个值是缺省的，nil
    func chooseCard(at index:Int) {//参数是卡片的数组中的位置索引        //*************这里没有采取翻到2个如果匹配立即消掉的策略，因为如果这样的话，假如第二个没有匹配，就全部反面了，你将无法看到它的图案。这里其实需要一个动画，如果匹配，全消，如果不匹配，先显示图案，然后全部反面。但是现在做不到，就先采取下面这种方案：等到翻下一个牌的时候再更新UI*********
        if (!cards[index].isMatched) {//未配对
            //有三种情况
            if let matchIndex = indexOfOneAndOnlyFaceUpCard {//如果不是nil
                if (matchIndex != index) {//有一张卡片正面朝上，且不是当前自己 这里把2个if语句合并了，是Swift的语法糖
                    //检查是否匹配
                    if (cards[matchIndex].identifier == cards[index].identifier){//如果匹配
                        cards[matchIndex].isMatched = true;
                        cards[index].isMatched = true;
                        cards[index].isFaceUp = true;//显示当前翻到的这张卡，因为是延迟更新UI，所以要显示
                        indexOfOneAndOnlyFaceUpCard = nil;
                    } else {//另一张翻到的没匹配
                            cards[matchIndex].isMatched = false;//本来就是false,可省
                            cards[index].isMatched = false;//本来就是false ,可省
                            cards[index].isFaceUp = true;//显示当前翻到的这张卡，因为是延迟更新UI，所以要显示
                            indexOfOneAndOnlyFaceUpCard = nil;
                         
                    }
                }// no else
            }else {//说明是第一次翻或当前没有卡片正面朝上的
                for flipDownIndex in cards.indices{
                       cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true;
                indexOfOneAndOnlyFaceUpCard = index;
            }
            
        }// no else
        
        print("cardNumber:\(index)")
        /*
        if cards[index].isFaceUp {//如果是正面，那就改成反面,反之，亦然
            cards[index].isFaceUp = false;
        } else {
            cards[index].isFaceUp = true;
        }*/
    }
    
    func reset(){
        for flipDownIndex in cards.indices{
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false;
        }
        indexOfOneAndOnlyFaceUpCard = nil;
        
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
        var temp = Card()
        var index = 0
        for point in cards.indices{
            let randomCase = Int(arc4random_uniform(UInt32(cards.count - point - 1)))
            index = randomCase + point
            if index != point{
                temp = cards[point]
                cards[point] = cards[index]
                cards[index] = temp
            }
        }
    
    }
    
    
}
