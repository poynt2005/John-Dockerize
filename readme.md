# JohnTheRipper-Dockerize

### 說明

[_倉庫鏈接_](https://github.com/poynt2005/John-Dockerize)  
將 john the ripper 以及其 GUI 專案 johnny 進行容器化，
若使用 GUI 介面時，不要點擊到 Help -> About Johnny，打開之後這邊沒有退出的按鈕，  
<span style="color:#c25d55">會無法操作主要的 GUI 介面</span>

### 建置

```
docker build -t john-gui .
```

### 運行

參考 runscript.txt 其中:

1. Your_noVNC_port: 你的 noVNC 連線埠
2. Your_VNC_port: 你的 VNC 連線埠
3. /path/to/your/data: 你要存放數據的卷宗
4. /path/to/your/config: john 設定檔的卷宗
5. /path/to/your/x11/config: x11 的卷宗

打開檔案的視窗目錄的預設為 /config，請切換為 /config/data

若不想運行 GUI 的話，可以直接將最後面的

```
-d poynt2005/john-gui
```

改成

```
-it poynt2005/john-gui sh
```

就可以在 shell 中調用 _john_ 指令來操作
