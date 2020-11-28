<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>设置首行缩进</title>
    <style>
        p{
            text-indent: 2em;
        }
        background-attachment:focus-visible;

        * {
            margin: 0;
            padding: 0;
        }

        .box {
            width: 320px;
            height: 427px;
            margin: 100px;
            border: 1px solid #ccc;
            position: relative;
        }

        .big {
            width: 375px;
            height: 500px;
            position: absolute;
            top: 0;
            left: 330px;
            border: 1px solid #ccc;
            overflow: hidden;
            display: none;
        }

        .big img {
            position: absolute;
        }

        .mask {
            width: 186px;
            height: 250px;
            background: rgba(255, 255, 0, 0.4);
            position: absolute;
            top: 0;
            left: 0;
            cursor: move;
            display: none;
        }

        .small {
            position: relative;
        }
    </style>
</head>
<body background="QQ图片20201128183034.jpg">
    
    <p>嗨嗨嗨嗨,现在是我自己的高光时刻，下面让我来隆重介绍一下自己</p>	
  <div id="bb">
    <div id="ee">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><hr /></td>
        </tr>
        <tr>
        <td><p>姓名：赵海梅</p></td>
        </tr>
        <tr>
          <td><p>性别：女</p></td>
        </tr>
        <tr>
          <td><p>年龄：永远18</p></td>
        </tr>
        <tr>
          <td>家乡：<a href="http://baike.baidu.com/link?url=ZkJSggcN2Nl7Xe0HaB0hSRrMkIdo-VGCNJWpbPIWNt1-M7xPr4FkF2qdxHGCMz3lT0LdGTsXi5zMtwMWKZ5S3Pz8elmt9ATA1omMMMfTIBSdG430mMTTJk0MyAlQO88B">广西壮族自治区贵港市平南县武林镇</a></td>
        </tr>
        <tr>
          <td>就读院校：<a href="http://baike.baidu.com/item/%E5%9B%9B%E5%B7%9D%E5%A4%A7%%A6">长沙工大学城南学院i</a></td>
        </tr>
        <tr>
          <td>就读专业：<a href="http://baike.baidu.com/item/%E5%BE%AE%E7%94%E7%A7%91%E5%AD%A6%E4%B8%8E%E5%B7%A5%E7%A8%8B%E4%B8%93%E4%B8%9A">通信工程</a></td>
        </tr>
        <tr>
          <td>学生证号：201916180207</td>
        </tr>
        <tr>
          <td>兴趣爱好：听歌，健身，爱吃，爱玩...</td>
        </tr>
        <tr>
          <td>政治面貌：团员</td>
        </tr>
        <tr>
          <td>联系电话：123456789</td>
        </tr>
        <tr>
          <td>关键词：小可爱</td>
        </tr>
        <tr>
          <td> </td>
        </tr>
      </table>
    </div>
    <div id="box" class="box">
        <div class="small">
            <img src="QQ图片20200921221052.jpg" width="320px" alt="">
            <div class="mask"></div>
        </div>
        <div class="big">
            <img src="QQ图片20201128183034.jpg" width="640px" alt="">
        </div>
    </div>
 

    <script>
        var box = document.getElementById('box');
        var smallBox = box.children[0];
        var smallImage = smallBox.children[0];
        var mask = smallBox.children[1];
        var bigBox = box.children[1];
        var bigImage = bigBox.children[0];

        function getPage(ev) {
            return {
                pageX: ev.clientX + (document.documentElement.scrollLeft || document.body.scrollLeft),
                pageY: ev.clientY + (document.documentElement.scrollTop || document.body.scrollTop)
            }
        }

        // 鼠标移入小盒子上，显示遮盖层和大图
        // 坑：由于鼠标移入时，有遮盖层和小盒子层，所以会产生事件冒泡。可以改用 onmouseenter 避免事件冒泡
        // smallBox.onmouseover = function () {
        smallBox.onmouseenter = function () {
            mask.style.display = 'block';
            bigBox.style.display = 'block';
        }

        // 同上
        // smallBox.onmouseout = function () {
        smallBox.onmouseleave = function () {
            mask.style.display = 'none';
            bigBox.style.display = 'none';
        }

        // 鼠标在小盒子上移动，遮盖层跟随移动
        smallBox.onmousemove = function (ev) {
            ev = ev || window.event;
            var x = getPage(ev).pageX - box.offsetLeft;
            var y = getPage(ev).pageY - box.offsetTop;

            // 将鼠标设置到遮蔽层的中间
            x -= mask.offsetWidth / 2;
            y -= mask.offsetHeight / 2;

            // 控制遮蔽层不能移出小盒子外
            x = x < 0 ? 0 : x;
            y = y < 0 ? 0 : y;
            // 遮蔽层最多能移动的距离
            var maxX = smallBox.offsetWidth - mask.offsetWidth;
            var maxY = smallBox.offsetHeight - mask.offsetHeight;
            x = x > maxX ? maxX : x;
            y = y > maxY ? maxY : y;

            mask.style.left = x + 'px';
            mask.style.top = y + 'px';

            // 显示大图的对应部分

            // 计算大图的偏移量：大图偏移量 / 遮蔽层的偏移量 = 大图最多能移动的距离 / 遮蔽层最多能移动的距离
            // 大图最多能移动的距离
            var bigMaxX = bigImage.offsetWidth - bigBox.offsetWidth;
            var bigMaxY = bigImage.offsetHeight - bigBox.offsetHeight;

            var bigImageX = x * bigMaxX / maxX;
            var bigImageY = y * bigMaxY / maxY;

            bigImage.style.left = -bigImageX + 'px';
            bigImage.style.top = -bigImageY + 'px';
        }
    </script>
</body>
</html>
