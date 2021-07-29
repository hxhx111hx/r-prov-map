library(tidyverse)
library(sf)
library(ggspatial)
library(hrbrthemes)
# 设定 ggplot2 绘图主题
theme_set(
  theme_ipsum(base_family = cnfont) + 
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          panel.grid.major = element_blank())
)

# 绘图
# 2019 年中国省级行政区划
read_rds("省份.rds") %>% 
  st_simplify(dTolerance = 2000) -> prov

read_rds("线条.rds") %>% 
  st_simplify(dTolerance = 2000) -> line

read_rds("标签.rds") -> label

# https://tidyfriday.cn/colors

ggplot() + 
  geom_sf(data = prov, aes(fill = 类型),
          color = "white", size = 0.3) + 
  geom_sf(data = line, aes(color = name, 
                           size = name),
          fill = NA) + 
  scale_fill_manual(
    name = "",
    values = c("不统计" = "#fed439",
               "特别行政区" = "#709ae1",
               "直辖市" = "#8a9197",
               "省" = "#d2af81",
               "自治区" = "#fd7446")
  ) + 
  scale_color_manual(
    name = "", 
    values = c("国界线" = "black",
               "海岸线" = "#0055AA",
               "秦岭-淮河线" = "#18BC9C",
               "小地图框格" = "black",
               "胡焕庸线" = "#E31A1C",
               "区域线-不统计" = "gray",
               "区域线-东北部" = "gray",
               "区域线-东部" = "gray",
               "区域线-西部" = "gray",
               "区域线-中部" = "gray")
  ) + 
  scale_size_manual(
    name = "",
    values = c("国界线" = 0.5,
               "海岸线" = 0.5,
               "秦岭-淮河线" = 0.8,
               "小地图框格" = 0.5,
               "胡焕庸线" = 0.8,
               "区域线-不统计" = 0.1,
               "区域线-东北部" = 0.1,
               "区域线-东部" = 0.1,
               "区域线-西部" = 0.1,
               "区域线-中部" = 0.1)
  ) + 
  geom_text(data = label, aes(x = X, y = Y,
                              label = cname),
            family = cnfont) + 
  annotation_scale(location = "bl", 
                   width_hint = 0.3, 
                   text_family = cnfont) +
  annotation_north_arrow(
    location = "tr", 
    which_north = "false",
    pad_x = unit(0.75, "cm"),
    pad_y = unit(0.5, "cm"),
    style = north_arrow_fancy_orienteering(
      text_family = cnfont
    )
  ) +
  labs(title = "使用 R 语言绘制 2019 年中国省级行政区划",
       subtitle = "绘制：微信公众号 RStata",
       caption = "注意：该图表是使用提前设计好的数据绘制的，无法更改坐标参考系")

ggsave("pic1.png", dpi = 200, width = 10, height = 8)

# 英文地图
ggplot() + 
  geom_sf(data = prov, mapping = aes(fill = 类型), color = "white", size = 0.1) + 
  geom_sf(data = line, aes(color = name,
                           size = name)) + 
  scale_color_manual(
    name = "",
    values = c("国界线" = "black", 
               "海岸线" = "lightblue", 
               "秦岭-淮河线" = "#c40003",
               "小地图框格" = "black", 
               "胡焕庸线" = "#00c19b", 
               "区域线-不统计" = "gray", 
               "区域线-东北部" = "gray", 
               "区域线-东部" = "gray", 
               "区域线-西部" = "gray", 
               "区域线-中部" = "gray"),
    labels = c("国界线" = "National boundary", "海岸线" = "Coastline",
               "秦岭-淮河线"= "Qinling Huaihe line", "小地图框格" = "Small map frame",
               "胡焕庸线" = "Hu Huanyong line", "区域线-不统计" = "Regional line - Not within the scope of statistics",
               "区域线-东北部" = "Regional line - northeast", "区域线-东部"= "Regional Line - East", 
               "区域线-西部" = "Regional line - West", "区域线-中部" = "Regional line - Middle")
  ) + 
  scale_size_manual(
    name = "",
    values = c("国界线" = 0.5, 
               "海岸线" = 0.5, 
               "秦岭-淮河线" = 1,
               "小地图框格" = 0.5, 
               "胡焕庸线" = 1, 
               "区域线-不统计" = 0.1, 
               "区域线-东北部" = 0.1, 
               "区域线-东部" = 0.1, 
               "区域线-西部" = 0.1, 
               "区域线-中部" = 0.1),
    labels = c("国界线" = "National boundary", "海岸线" = "Coastline",
               "秦岭-淮河线"= "Qinling Huaihe line", "小地图框格" = "Small map frame",
               "胡焕庸线" = "Hu Huanyong line", "区域线-不统计" = "Regional line - Not within the scope of statistics",
               "区域线-东北部" = "Regional line - northeast", "区域线-东部"= "Regional Line - East", 
               "区域线-西部" = "Regional line - West", "区域线-中部" = "Regional line - Middle")
  ) + 
  scale_fill_manual(
    name = "",
    values = c("不统计" = "#fed439",
               "特别行政区" = "#709ae1",
               "直辖市" = "#8a9197",
               "省" = "#d2af81",
               "自治区" = "#fd7446"),
    labels = c("不统计" = "Not within the scope of statistics",
               "特别行政区" = "Special administrative region",
               "直辖市" = "Municipality directly under\nthe Central Government",
               "省" = "Province",
               "自治区" = "Autonomous Region")
  ) + 
  geom_text(data = label, aes(x = X, y = Y,
                              label = ename),
            family = cnfont, size = 3) + 
  labs(title = "Using R language to draw China's provincial map in 2019",
       subtitle = "WeChat Subscription: RStata",
       caption = "Note: the chart is drawn with the data designed in advance, and the coordinate reference system cannot be changed")

ggsave("pic2.png", dpi = 200, width = 14, height = 9)

# 2020 年中国各省市地区生产总值
read_csv('2020年中国各省市地区生产总值.csv') %>% 
  mutate(省 = str_sub(省份, 1, 2)) -> df

prov %>% 
  mutate(省 = str_sub(省, 1, 2)) %>% 
  left_join(df) -> df

line %>% 
  slice(1, 2, 4) -> line1

ggplot() + 
  geom_sf(data = df, aes(fill = 地区生产总值),
          color = "white", size = 0.1) + 
  geom_sf(data = line1, aes(color = name, 
                           size = name),
          fill = NA, show.legend = F) + 
  scale_fill_gradientn(
    name = c("地区生产总值（亿元）"),
    breaks = c(0, 20000, 40000, 
               60000, 80000, 100000), 
    colors = c("#e0f2f1", "#b2dfdb", 
               "#80cbc4", "#4db6ac", 
               "#26a69a", "#009688")
  ) +
  scale_color_manual(
    name = "", 
    values = c("国界线" = "black",
               "海岸线" = "#0055AA",
               "小地图框格" = "black")
  ) + 
  scale_size_manual(
    name = "",
    values = c("国界线" = 0.5,
               "海岸线" = 0.5,
               "小地图框格" = 0.5)
  ) + 
  geom_text(data = label, aes(x = X, y = Y,
                              label = cname),
            family = cnfont) + 
  annotation_scale(location = "bl", 
                   width_hint = 0.3, 
                   text_family = cnfont) +
  annotation_north_arrow(
    location = "tr", 
    which_north = "false",
    pad_x = unit(0.75, "cm"),
    pad_y = unit(0.5, "cm"),
    style = north_arrow_fancy_orienteering(
      text_family = cnfont
    )
  ) +
  labs(title = "2020 年中国各省市地区生产总值",
       subtitle = "绘制：微信公众号 RStata",
       caption = "数据来源：各地统计局") + 
  theme(legend.position = c(0.1, 0.2),
        legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 10))

ggsave("pic3.png", dpi = 200, width = 10, height = 8)

# 2013 年中国工企业分布及距离秦岭淮河的距离
haven::read_dta('gq2013sample.dta') %>% 
  st_as_sf(coords = c("经度", "纬度"), crs = 4326) %>% 
  st_transform(st_crs(prov)) -> df1

ggplot() + 
  geom_sf(data = prov, 
          color = "black", size = 0.1,
          fill = NA) + 
  geom_sf(data = slice(line, 1, 4), color = "black",
          size = 0.5) + 
  geom_sf(data = slice(line, 2), color = "lightblue",
          size = 0.5) + 
  geom_sf(data = slice(line, 3), color = "blue",
          size = 1) + 
  geom_sf(data = df1, aes(size = 与秦岭淮河线的距离,
                          color = 北方或南方),
          alpha = 0.6) + 
  scale_color_manual(
    name = "", 
    values = c("秦岭淮河以北" = "#E31A1C",
               "秦岭淮河以南" = "#18BC9C")
  ) + 
  scale_size_continuous(
    name = "与秦岭淮河线的距离(km)",
    breaks = c(0, 400, 800, 1200, 1600, 1800, 2000),
    range = c(0.01, 4)
  ) + 
  geom_text(data = subset(label, cname == "南海诸岛"),
            aes(x = X, y = Y, label = cname),
            family = cnfont) + 
  annotation_scale(location = "bl", 
                   width_hint = 0.3, 
                   text_family = cnfont) +
  annotation_north_arrow(
    location = "tr", 
    which_north = "false",
    pad_x = unit(0.75, "cm"),
    pad_y = unit(0.5, "cm"),
    style = north_arrow_fancy_orienteering(
      text_family = cnfont
    )
  ) +
  labs(title = "2013 年中国工业企业与秦岭-淮河线的距离",
       subtitle = "绘制：微信公众号 RStata",
       caption = "数据来源：2013 年中国工业企业数据库，使用高德地图地理编码接口解析经纬度") + 
  theme(legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 10))

ggsave("pic4.png", dpi = 200, width = 10, height = 8)

# 2019 年中国各省地区生产总值 & 产业结构
library(scatterpie)
library(ggnewscale)
haven::read_dta('各省历年GDP.dta') %>% 
  dplyr::filter(省份 != "中国") %>% 
  mutate(地区生产总值 = 地区生产总值_亿元 / 1000) %>% 
  dplyr::filter(年份 == 2019) %>% 
  mutate(cname2 = str_sub(省份, 1, 2)) -> df2

label %>% 
  mutate(cname2 = str_sub(cname, 1, 2)) %>% 
  left_join(df2) %>% 
  dplyr::filter(!is.na(第一产业占GDP比重_百分比)) -> piedata

prov %>% 
  left_join(df2) -> df2

ggplot() + 
  geom_sf(data = df2, aes(fill = 地区生产总值),
          size = 0.1, color = "white") + 
  scale_fill_gradientn(
    name = c("地区生产总值（千亿元）"),
    breaks = c(0, 20, 40, 
               60, 80, 100), 
    colors = c("#e0f2f1", "#b2dfdb", 
               "#80cbc4", "#4db6ac", 
               "#26a69a", "#009688")
  ) + 
  new_scale_fill() + 
  geom_sf(data = slice(line, 1, 4), color = "black",
          size = 0.5) + 
  geom_sf(data = slice(line, 2), color = "lightblue",
          size = 0.3) + 
  geom_scatterpie(data = piedata,
                  aes(X, Y, group = cname),
                  pie_scale = 1.5,
                  cols = c("第一产业占GDP比重_百分比",
                           "第二产业占GDP比重_百分比",
                           "第三产业占GDP比重_百分比"),
                  color = NA) + 
  scale_fill_manual(values = c("#fed439", "#709ae1", "#d2af81"),
                    labels = c("第一产业占比(%)",
                               "第二产业占比(%)",
                               "第三产业占比(%)"),
                    name = "占GDP比重") + 
  geom_text(data = subset(label, cname == "南海诸岛"),
            aes(x = X, y = Y, label = cname),
            family = cnfont) + 
  annotation_scale(location = "bl", 
                   width_hint = 0.3, 
                   text_family = cnfont) +
  annotation_north_arrow(
    location = "tr", 
    which_north = "false",
    pad_x = unit(0.75, "cm"),
    pad_y = unit(0.5, "cm"),
    style = north_arrow_fancy_orienteering(
      text_family = cnfont
    )
  ) +
  labs(title = "2019 年中国各省地区生产总值 & 产业结构",
       subtitle = "绘制：微信公众号 RStata",
       caption = "数据来源：CSMAR经济金融数据库") + 
  theme(legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 10))

ggsave("pic5.png", dpi = 200, width = 10, height = 8)

# 连续变量转换成分组变量
df2 %>% 
  mutate(group = case_when(
    is.na(地区生产总值) ~ "数据缺失",
    between(地区生产总值, 0, 40) ~ "< 40千亿",
    between(地区生产总值, 40, 60) ~ "40～60千亿",
    between(地区生产总值, 60, 80) ~ "60～80千亿",
    between(地区生产总值, 80, 100) ~ "80～100千亿",
    地区生产总值 > 100 ~ "> 100千亿",
  )) %>% 
  mutate(group = factor(
    group, 
    levels = c(
      "数据缺失", "< 40千亿",
      "40～60千亿", "60～80千亿",
      "80～100千亿", "> 100千亿"
    )
  )) -> df3

ggplot() + 
  geom_sf(data = df3, aes(fill = group),
          size = 0.1, color = "white") + 
  scale_fill_manual(
    name = "地区生产总值",
    values = c(
      "数据缺失" = "gray",
      "< 40千亿" = "#b2dfdb",
      "40～60千亿" = "#80cbc4",
      "60～80千亿" = "#4db6ac",
      "80～100千亿" = "#26a69a",
      "> 100千亿" = "#009688"
    )
  ) + 
  new_scale_fill() + 
  geom_sf(data = slice(line, 1, 4), color = "black",
          size = 0.5) + 
  geom_sf(data = slice(line, 2), color = "lightblue",
          size = 0.3) + 
  geom_scatterpie(data = piedata,
                  aes(X, Y, group = cname),
                  pie_scale = 2.5,
                  cols = c("第一产业占GDP比重_百分比",
                           "第二产业占GDP比重_百分比",
                           "第三产业占GDP比重_百分比"),
                  color = NA) + 
  scale_fill_manual(values = c("#fed439", "#709ae1", "#d2af81"),
                    labels = c("第一产业占比(%)",
                               "第二产业占比(%)",
                               "第三产业占比(%)"),
                    name = "占GDP比重") + 
  geom_text(data = label, aes(x = X, y = Y,
                              label = cname),
            family = cnfont, size = 4) + 
  annotation_scale(location = "bl", 
                   width_hint = 0.3, 
                   text_family = cnfont) +
  annotation_north_arrow(
    location = "tr", 
    which_north = "false",
    pad_x = unit(0.75, "cm"),
    pad_y = unit(0.5, "cm"),
    style = north_arrow_fancy_orienteering(
      text_family = cnfont
    )
  ) +
  labs(title = "2019 年中国各省地区生产总值 & 产业结构",
       subtitle = "绘制：微信公众号 RStata",
       caption = "数据来源：CSMAR经济金融数据库") + 
  theme(legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 10))

ggsave("pic6.png", dpi = 200, width = 10, height = 8)

# 各省人口密度
haven::read_dta('中国人口空间分布省级面板数据集.dta') %>% 
  dplyr::filter(年份 == 2015) %>% 
  rename(省 = 省份) %>% 
  left_join(prov, .) -> df4

ggplot() + 
  geom_sf(data = df4, aes(fill = 均值),
          size = 0.1, color = "white") + 
  scale_fill_gradientn(
    name = c("平均人口密度"),
    breaks = c(0, 1000, 2000, 3000, 4000), 
    colors = c("#e0f2f1", "#b2dfdb", 
               "#80cbc4", "#4db6ac", 
               "#26a69a", "#009688")
  ) + 
  geom_sf(data = slice(line, 1, 4), color = "black",
          size = 0.5) + 
  geom_sf(data = slice(line, 2), color = "lightblue",
          size = 0.3) + 
  geom_sf(data = slice(line, 5), color = "#E31A1C",
          size = 1) + 
  geom_text(data = label, aes(x = X, y = Y,
                              label = cname),
            family = cnfont, size = 4) + 
  annotation_scale(location = "bl", 
                   width_hint = 0.3, 
                   text_family = cnfont) +
  annotation_north_arrow(
    location = "tr", 
    which_north = "false",
    pad_x = unit(0.75, "cm"),
    pad_y = unit(0.5, "cm"),
    style = north_arrow_fancy_orienteering(
      text_family = cnfont
    )
  ) +
  labs(title = "2015 年中国各省平均人口密度",
       subtitle = "绘制：微信公众号 RStata",
       caption = "数据来源：中国科学院资源环境科学与数据中心") + 
  theme(legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 10))

ggsave("pic7.png", dpi = 200, width = 10, height = 8)
