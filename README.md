# 使用 R 语言绘制中国省级地图！比例尺、指北针、秦岭-淮河线、胡焕庸线、海岸线、未定国界都有！

> 欢迎前往 [哔哩哔哩](https://www.bilibili.com/video/BV1Dq4y1X74c/) 查看该项目的视频讲解：https://www.bilibili.com/video/BV1Dq4y1X74c/ 

根据大家之前的一些反馈，我们又重新设计了一份使用 R 语言绘制省级地图的数据，这次的地图数据比起之前的版本有如下变化：

1. 指北针变得竖直了！
2. 包含了未定国界；
3. 添加了海岸线；
4. 添加了秦岭-淮河线；
5. 添加了胡焕庸线；
6. 添加了英文版本！
7. 比例尺和指北针的位置可以移动了！

为了让大家更好的学习这份地图数据的使用，我们设计了下面的这些案例：

![](https://mdniceczx.oss-cn-beijing.aliyuncs.com/image_20210710195941.png)

之前在公众号分享过使用 Stata 绘制中国省级、市级和区县地图的方法：

1. [使用 Stata 绘制中国省级地图！比例尺、指北针、秦岭-淮河线、胡焕庸线、海岸线、未定国界都有！](https://mp.weixin.qq.com/s/IU-YZfibhj8_ogo9PE9sPw)
2. [中国市级地图！Stata 也可以画！点击领取免费数据和使用方法视频讲解！](https://mp.weixin.qq.com/s/X6lQ5zy0L0XplLsNw9sT6A)
3. [区县地图！Stata 也可以绘制这么漂亮的地图！免费分享给大家！](https://mp.weixin.qq.com/s/-8sa2bgx76XWq75WCtzqVw)

很多小伙伴想学习如何使用 R 语言绘制类似的图表，所以就打算推出类似的三个 R 语言的课程。明晚的直播课将会讲解如何使用 R 语言绘制中国省级地图。

为了让大家更好的掌握使用 R 语言绘制中国省级行政区划地图的方法，我们设计了如下案例：

> 虽然现在是 2021 年了，但是大多数经济数据还只到 2019 年，所以提供的数据是 2019 年的版本。

## 2019 年中国省级行政区划

![](https://mdniceczx.oss-cn-beijing.aliyuncs.com/image_20210710183135.png)

为了方便大家使用，我们贴心的添加了秦岭-淮河线、国界线、海岸线、胡焕庸线、比例尺和指北针。另外特别容易忽略的一点就是未定国界（新疆的左上角）：

![](https://mdniceczx.oss-cn-beijing.aliyuncs.com/image_20210710183459.png)

## 英文版本

把所有的中文标签都替换成英语的就可以得到一副英文地图了（下图的英文都是使用百度翻译的）：

![](https://mdniceczx.oss-cn-beijing.aliyuncs.com/image_20210710183521.png)

## 2020 年中国各省市地区生产总值

我们通常绘制的地图有两大类：填充地图和描点地图，填充地图的又可以分为离散变量的填充和连续变量的填充，上面的 2019 年中国省级行政区划地图实际上就是离散变量的填充，下面是个连续变量填充的示例：2020 年中国各省市地区生产总值

![](https://mdniceczx.oss-cn-beijing.aliyuncs.com/image_20210710184648.png)

## 2013 年中国工企业分布及距离秦岭淮河的距离

描点地图也就是在地图上添加一个个坐标点，例如我们在地图上展示 2013 年中国工企业分布及距离秦岭淮河的距离：

![](https://mdniceczx.oss-cn-beijing.aliyuncs.com/image_20210710184746.png)

这里用颜色表示南北方的工企业、散点的大小表示与秦岭淮河线的距离。

## 2019 年中国各省地区生产总值 & 产业结构

填充地图通常可以和饼图和柱形图结合来展示更多的信息，这种图的绘制通常是先绘制好每一个图再用拼图软件组合起来，不过使用 scatterpie 包可以很容易实现在地图上添加饼图：

![](https://mdniceczx.oss-cn-beijing.aliyuncs.com/image_20210710185146.png)

这里用饼图展示每个省份的一二三产业比重。

柱形图的添加在 ggplot2 里面看起来似乎还没有特别好的方法。

## 连续变量转换成分组变量

连续变量可以通过分组转换成排序变量（也是离散变量），分组可以用 cut() 函数，不过不如 case_when() 函数简单明了：

![](https://mdniceczx.oss-cn-beijing.aliyuncs.com/image_20210710185349.png)

## 2015 年各省人口密度

我们再来看一下胡焕庸线的使用：

![](https://mdniceczx.oss-cn-beijing.aliyuncs.com/image_20210710185423.png)

------------

<h4 align="center">

Code of Conduct

</h4>

<h6 align="center">

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md).<br>By participating in this project you
agree to abide by its terms.

</h6>

<h4 align="center">

License

</h4>

<h6 align="center">

MIT © 微信公众号 RStata

</h6>
