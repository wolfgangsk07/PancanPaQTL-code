
var floatPanel_x, floatPanel_y; //鼠标相对与div左边，上边的偏移
var isDrop = false; //移动状态的判断鼠标按下才能移动
floatPanel.onmousedown = function(e) {
    var e = e || window.event; //要用event这个对象来获取鼠标的位置
    floatPanel_x = e.clientX - floatPanel.offsetLeft;
    floatPanel_y = e.clientY - floatPanel.offsetTop;
    isDrop = true; //设为true表示可以移动
}
 
document.onmousemove = function(e) {
    //是否为可移动状态    　　　　　　　　　　　 　　　　　　　
    if(isDrop) {　　　　
        var e = e || window.event;        　　
        var moveX = e.clientX - floatPanel_x; //得到距离左边移动距离        　　
        var moveY = e.clientY - floatPanel_y; //得到距离上边移动距离
        //可移动最大距离
        var maxX = document.documentElement.clientWidth - floatPanel.offsetWidth;
        var maxY = document.documentElement.clientHeight - floatPanel.offsetHeight;
 
        //范围限定  当移动的距离最小时取最大  移动的距离最大时取最小
        //范围限定方法一
        /*if(moveX < 0) {
moveX = 0
        } else if(moveX > maxX) {
moveX = maxX;
        }
 
        if(moveY < 0) {
moveY = 0;
        } else if(moveY > maxY) {
moveY = maxY;
        }　*/
        //范围限定方法二　
        moveX=Math.min(maxX, Math.max(0,moveX));
         
        moveY=Math.min(maxY, Math.max(0,moveY));
        floatPanel.style.left = moveX + "px";　　
        floatPanel.style.top = moveY + "px";　　　　　　　　　　
    } else {
        return;　　　　　　　　　　
    }
 
}
 
document.onmouseup = function() {
    isDrop = false; //设置为false不可移动
}