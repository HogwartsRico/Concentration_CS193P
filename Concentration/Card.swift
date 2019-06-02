//
//  Card.swift
//  Concentration
//
//  Created by rico on 2019/4/8.
//  Copyright © 2019 Rico. All rights reserved.
//这是一个Model,它是Struct,不是class

import Foundation
struct Card {//这个就是每张卡片的model
    var isFaceUp=false;//是否正面朝上 开始的时候正面朝下的
    var isMatched=false;//是否匹配
    var identifier:Int; //唯一标识
    
    static var identifierFactory=0;//静态变量
    static func getUniqueIdentifier()->Int {//静态方法
        Card.identifierFactory+=1;//每次都会加1，生成一个唯一的数字
        return identifierFactory;
    }
    init() {//构造函数 另外struct有一个默认的为所有成员变量进行初始化的构造函数
        self.identifier=Card.getUniqueIdentifier();//为本实例的identifier赋值,其值为全局累加 ,self类似于Java的this
    }
}
