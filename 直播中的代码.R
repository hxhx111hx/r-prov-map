library(tidyverse)
library(sf)
library(ggspatial)
library(hrbrthemes)

# 设置 ggplot2 绘图主题
theme_set(
  theme_ipsum(base_family = cnfont) + 
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          panel.grid.major = element_blank())
)

read_rds('省份.rds') %>% 
  st_simplify(dTolerance = 2000) -> prov
read_rds('线条.rds') %>% 
  st_simplify(dTolerance = 2000) -> line
read_rds('标签.rds') -> label

prov 
line 
label

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

# 2020 年中国各省市地区生产总值
read_csv('2020年中国各省市地区生产总值.csv') -> df

prov %>% 
  mutate(prov = str_sub(省, 1, 2)) -> prov2

df %>% 
  mutate(prov = str_sub(省份, 1, 2)) -> df2

prov2 %>% 
  left_join(df2) %>% 
  select(省份, 地区生产总值) -> df2

line %>% 
  slice(1, 2, 4) -> line2

ggplot() + 
  geom_sf(data = df2, mapping = aes(fill = 地区生产总值), color = "white", size = 0.1) + 
  geom_sf(data = line2, aes(color = name,
                           size = name),
          show.legend = F) + 
  scale_color_manual(
    name = "",
    values = c("国界线" = "black", 
               "海岸线" = "lightblue", 
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
            family = cnfont, size = 3) + 
  scale_fill_gradientn(
    name = "地区生产总值（亿元）",
    breaks = c(0, 20000, 40000, 
               60000, 80000, 100000), 
    colors = c("#e0f2f1", "#b2dfdb", 
               "#80cbc4", "#4db6ac", 
               "#26a69a", "#009688")
  )

haven::read_dta('gq2013sample.dta') -> df4
df4 %>% 
  st_as_sf(coords = c("经度", "纬度"), crs = 4326) %>% 
  st_transform(st_crs(prov)) -> df4

df4

line %>% 
  slice(1, 2, 3, 4) -> line3

ggplot() + 
  geom_sf(data = prov, fill = NA, size = 0.3) + 
  geom_sf(data = slice(line3, 1, 4), color = "black", size = 0.5) + 
  geom_sf(data = slice(line3, 2), color = "lightblue", size = 0.5) + 
  geom_sf(data = slice(line3, 3), color = "#c40003", size = 1.2) + 
  geom_sf(data = df4, aes(color = 北方或南方,
                          size = 与秦岭淮河线的距离), alpha = 0.2) +
  scale_color_manual(
    values = c(
      "秦岭淮河以北" = "#762a83",
      "秦岭淮河以南" = "#1b7837"
    )
  ) + 
  scale_size_continuous(
    range = c(0.01, 4),
    name = "与秦岭淮河线的距离(km)",
    breaks = c(0, 400, 800, 1200, 1600, 1800, 2000)
  ) + 
  labs(title = "2013 年中国工业企业与秦岭-淮河线的距离",
       subtitle = "绘制：微信公众号 RStata",
       caption = "数据来源：2013 年中国工业企业数据库，使用高德地图地理编码接口解析经纬度") + 
  theme(legend.key.size = unit(0.5, "cm"),
        legend.title = element_text(size = 10))
  
# 2019 年中国各省地区生产总值 & 产业结构
haven::read_dta('各省历年GDP.dta') %>% 
  dplyr::filter(省份 != "中国") %>% 
  mutate(地区生产总值 = 地区生产总值_亿元 / 1000) %>% 
  dplyr::filter(年份 == 2019) %>% 
  mutate(prov = str_sub(省份, 1, 2)) -> df6

prov2 %>% 
  left_join(df6) -> df6
library(scatterpie)
label %>% 
  mutate(prov = str_sub(cname, 1, 2)) %>% 
  left_join(df6) %>% 
  select(X, Y, cname, ends_with("百分比")) %>% 
  dplyr::filter(!is.na(第一产业占GDP比重_百分比)) -> piedata

library(ggnewscale)

df6 %>% 
  mutate(group = case_when(
    is.na(地区生产总值) ~ "无数据",
    between(地区生产总值, 0, 40) ~ "< 40千亿",
    between(地区生产总值, 40, 60) ~ "40～60千亿",
    between(地区生产总值, 60, 80) ~ "60～80千亿",
    between(地区生产总值, 80, 100) ~ "80～100千亿",
    地区生产总值 > 100 ~ "> 100千亿",
  )) %>% 
  mutate(group = factor(
    group, 
    levels = c(
      "无数据", "< 40千亿",
      "40～60千亿", "60～80千亿",
      "80～100千亿", "> 100千亿"
    )
  )) -> df6

ggplot() + 
  geom_sf(data = df6, mapping = aes(fill = group), color = "white", size = 0.1) + 
  geom_sf(data = line2, aes(color = name,
                            size = name),
          show.legend = F) + 
  scale_color_manual(
    name = "",
    values = c("国界线" = "black", 
               "海岸线" = "lightblue", 
               "小地图框格" = "black")
  ) + 
  scale_size_manual(
    name = "",
    values = c("国界线" = 0.5, 
               "海岸线" = 0.5, 
               "小地图框格" = 0.5)
  ) + 
  scale_fill_manual(
    name = "地区生产总值",
    values = c(
      "无数据" = "gray",
      "< 40千亿" = "#b2dfdb",
      "40～60千亿" = "#80cbc4",
      "60～80千亿" = "#4db6ac",
      "80～100千亿" = "#26a69a",
      "> 100千亿" = "#009688"
    )
  ) + 
  new_scale_fill() + 
  geom_scatterpie(data = piedata, 
                  aes(X, Y), 
                  cols = c("第一产业占GDP比重_百分比",
                           "第二产业占GDP比重_百分比",
                           "第三产业占GDP比重_百分比"),
                  pie_scale = 2,
                  color = NA) + 
  geom_text(data = label, aes(x = X, y = Y,
                              label = cname),
            family = cnfont, size = 3) + 
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
  )

