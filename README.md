# 食譜採購比價網

## 作者名字
楊平 samabc75@gmail.com

彭選庭 a84926601@gmail.com

徐康恆wa0125678665@gmail.com

陳維廷 hi@arthurchen.me

曹又升 404261189@gapp.fju.edu.tw

## License
[MIT](https://github.com/NetJagaimo/foodprice/blob/main/LICENSE)

## 欲解決之問題
- 整合食譜、採購、比價於一身，提供一站式採購服務，並且同時蒐集個網站的食材價格，確保使用者可以用最划算的方式購買食材，並依照心儀的食譜進行料理。
- 使用者可於本網站搜尋食譜，搜尋到食譜後會自動跳出該食譜所需之食材，並於各購物網站抓取食材資訊，讓使用者可以透過一站式的比價，買到最划算的食材。
### 資料來源網站
[愛料理](https://icook.tw/)

[momo購物網](https://www.momoshop.com.tw/main/Main.jsp)

[遠傳Friday購物](https://shopping.friday.tw/index.html)

### 使用者界面
* 首頁
![](https://i.imgur.com/M0bAiyF.png)

* 搜尋頁面
![](https://i.imgur.com/yrnUV0g.png)

* 食譜頁面
![](https://i.imgur.com/VJd4SMf.png)

* 比價頁面
![](https://i.imgur.com/WNG8WuL.png)

## 使用到的技術
Backend: Fastapi, Fastapi-cache2, redis, uvicorn, gunicorn
Frontend: Flutter

## 安裝說明
### [Backend Installation](https://github.com/NetJagaimo/foodprice/blob/main/backend/README.md)

### Frontend Installation

* 將原始碼編譯成網頁
```
flutter build web
```
* 進到網頁工作目錄
```
cd build/web
```
* 利用Python作為網頁伺服器進行快速瀏覽，即可透過http://127.0.0.1:8000上前端網頁
```
python3 -m http.server 8000
```

## 未來規劃
- 提供更多家購物網站的比價資訊
- 與電商合作提供優惠並協助電商進行導購
- 與食譜網站合作