//
//  testPosts.swift
//  Navigation
//
//  Created by Kirill Krasavin on 24.02.2022.
//

import Foundation

let testPostArray: [Post] = [firstPost, secondPost, thirdPost, fourthPost]

private let firstPost = Post(title: "Я с женой",
                     author: "Котик",
                     discription: "Для счастливой семейной жизни важен характер супругов, а для развлечений достаточно одной только смазливой внешности.",
                     image: "wife")

private let secondPost = Post(title: "Мой 3.14здюк",
                     author: "Котик",
                     discription: "Мать укладывает ребёнка спать:\n- Золотко моё, если тебе ночью что-нибудь понадо­бится - крикни маму, и папа сейчас же прибежит к тебе.",
                     image: "child")

private let thirdPost = Post(title: "Я на работе",
                     author: "Котик",
                     discription: "- Вась, а у тебя какой профессиональный праздник?\n- День офтальмолога и День строителя.\n- Кем же ты работаешь?\n- Глазки в двери вставляю.",
                     image: "job")

private let fourthPost = Post(title: "Очень сегодня устал",
                     author: "Котик",
                     discription: "Медицинская наука уже который век не может победить захватившую весь мир эпидемию лени, усталости и безразличия. А, впрочем, забейте.",
                     image: "tired")

