import { RefreshConst } from '../../components/refresh/RefreshConst';
import PageTitle from '../../../../components/PageTitle';
import { WaterFlowDataSource } from '../../test/WaterFlowDataSource';
import router from '@ohos.router';


export const shopDataList = []

@Component
@Preview
export default struct ShopHome {
  // @State text: string = '';
  @State iconList: any = [
    [
      { icon: $r('app.media.ic_home_1_1'), name: '数码家电' },
      { icon: $r('app.media.ic_home_1_2'), name: '神券神价' },
      { icon: $r('app.media.ic_home_1_3'), name: '美妆个护' },
      { icon: $r('app.media.ic_home_1_4'), name: '钱币馆' },
      { icon: $r('app.media.ic_home_1_5'), name: '家居日用' },
    ],
    [
      { icon: $r('app.media.ic_home_1_6'), name: '会员充值' },
      { icon: $r('app.media.ic_home_1_7'), name: '食品饮料' },
      { icon: $r('app.media.ic_home_1_8'), name: '淘宝红包' },
      { icon: $r('app.media.ic_home_1_9'), name: '黄金珠宝' },
      { icon: $r('app.media.ic_home_1_10'), name: '京东优选' }
    ],
  ]
  @State imageList: any = [
    { imageUrl: $r('app.media.home') },
    { imageUrl: $r('app.media.home') },
    { imageUrl: $r('app.media.home') },
  ]
  @State couponCollectionList: any = [
    { icon: $r('app.media.ic_home_4_2'), name: '蓝漂洗衣液', price: '9.9' },
    { icon: $r('app.media.ic_home_4_3'), name: '晶东变色唇膏', price: '9.9' },
    { icon: $r('app.media.ic_home_4_4'), name: '超威强力洁厕精', price: '9.9' },
  ]
  @State exchangePointsList: any = [
    { icon: $r('app.media.ic_home_5_1'), name: '清风抽纸*6包', price: '8.8+62积点' },
    { icon: $r('app.media.ic_home_5_2'), name: '秋冬情侣拖鞋', price: '8.8+62积点' },
    { icon: $r('app.media.ic_home_5_3'), name: '东北香米1.5Kg', price: '10.5+62积点' },
    { icon: $r('app.media.ic_home_5_4'), name: '薇诺娜特护霜', price: '58+62积点' },
    { icon: $r('app.media.ic_home_5_5'), name: '零趣焦糖饼干', price: '6+62积点' },
  ]
  @State popularRecommendationsList: any = [
  // { id:1, icon: $r('app.media.ic_home_6_1'), name: '华为（HUAWEI）Mate60 Pro 旗舰手机 12GB+512GB 雅丹黑', price: '￥ 7788.00' },
  // { id:2, icon: $r('app.media.ic_home_6_2'), name: '汾酒 红盖玻汾 清香型白酒 42度 475mL 6瓶 整箱装', price: '￥ 319.10 ', sold: '已售:200+' },
  // { id:3, icon: $r('app.media.ic_home_6_3'), name: 'Appleipadpro 2022款苹果平板电脑 未使用 海外版 22款ipad pro11寸 灰色 256G WiFi版 未使用 店保一年', price: '￥ 5989.00' },
  // { id:4, icon: $r('app.media.ic_home_6_4'), name: '三星（SAMSUNG）110英寸 Micro LED自发光全倒装 COB封装大屏无边框智能显示屏 家用巨幕 MNA110MS1ACXXZ 一价无忧', price: '￥ 1049999.00' },
  // { id:5, icon: $r('app.media.ic_home_6_5'), name: '三星 SAMSUNG 心系天下 W24 16GB+1TB 纳多灰 附S Pen 超闭合折叠 尊奢铰链 轻型化陶瓷 5G折叠屏手机', price: '￥ 15999.00' },
  // { id:6, icon: $r('app.media.ic_home_6_6'), name: '光明纯牛奶250mL*24盒 家庭量贩装 浓醇营养早餐伴侣', price: '￥ 67.80' },


  // { icon: $r('app.media.home'), name: '清风抽纸*6包', price: '8.8+62积点' },
  // { icon: $r('app.media.home'), name: '秋冬情侣拖鞋', price: '8.8+62积点', sold: '已售:200+' },
  // { icon: $r('app.media.home'), price: '10.5+62积点' },
  // { icon: $r('app.media.home'), name: '薇诺娜特护霜', price: '58+62积点' },
  // { icon: $r('app.media.home'), name: '零趣焦糖饼干', price: '6+62积点', sold: '已售:3000+' },
  // { icon: $r('app.media.home'), name: '清风抽纸*6包', price: '8.8+62积点' },
  // { icon: $r('app.media.home'), name: '秋冬情侣拖鞋', price: '8.8+62积点', sold: '已售:200+' },
  // { icon: $r('app.media.home'), price: '10.5+62积点' },
  // { icon: $r('app.media.home'), name: '薇诺娜特护霜', price: '58+62积点' },
  // { icon: $r('app.media.home'), name: '零趣焦糖饼干', price: '6+62积点', sold: '已售:3000+' },
  // { icon: $r('app.media.home'), name: '清风抽纸*6包', price: '8.8+62积点' },
  // { icon: $r('app.media.home'), name: '秋冬情侣拖鞋', price: '8.8+62积点', sold: '已售:200+' },
  // { icon: $r('app.media.home'), price: '10.5+62积点' },
  // { icon: $r('app.media.home'), name: '薇诺娜特护霜', price: '58+62积点' },
  // { icon: $r('app.media.home'), name: '零趣焦糖饼干', price: '6+62积点', sold: '已售:3000+' },
  ]
  private listController: Scroller = null;
  controller: TextInputController = new TextInputController()
  private swiperController: SwiperController = new SwiperController()
  // private swiperImageController: SwiperController = new SwiperController()
  private scroller: Scroller = new Scroller();
  // private scroller1: Scroller = new Scroller();

  // datasource: WaterFlowDataSource = new WaterFlowDataSource()
  private itemWidthArray: number[] = []
  private itemHeightArray: number[] = []
  @State maxSize: number = 100
  @State minSize: number = 50

  @Builder itemHead() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      Text('热门推荐').fontWeight('bold')
      Text('积点兑换').fontWeight('bold')
      Text('有价票券').fontWeight('bold')
      Text('家居日用').fontWeight('bold')
    }.height(48).padding({ right: 12, left: 12 })
    .backgroundColor(Color.White)
  }

  @Builder itemFoot() {
    Column() {
      Text(`Footer`)
        .fontSize(10)
        .backgroundColor(Color.Red)
        .width(50)
        .height(50)
        .align(Alignment.Center)
        .margin({ top: 2 })
    }
  }

  // 计算flow item宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  // 保存flow item宽/高
  getItemSizeArray() {
    for (let i = 0; i < 100; i++) {
      this.itemWidthArray.push(this.getSize())
      this.itemHeightArray.push(this.getSize())
    }
  }

  aboutToAppear() {
    this.popularRecommendationsList = shopDataList;
    // this.getItemSizeArray()
  }

  buildScroller(): Scroller {
    if (this.listController != null) {
      return this.listController
    }
    // new Scroller();
    this.listController = new Scroller();
    return this.listController;
  }

  @Builder homeLayout() {
    List({ scroller: this.buildScroller() }) {
      // List() {
      // ListItem() {
      //   RefreshLayout()
      // }
      ListItemGroup() {
        ListItem() {
          Row() {
            Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
              TextInput().fontWeight('bold')
                // .enabled(false)
            }.width('90%').height(48).padding({ right: 12, left: 12 })

            Image($r('app.media.shopping_unselected')).fillColor('#fff').width(24)
          }.width('100%').backgroundColor(Color.White)
        }

        ListItem() {
          Column() {
            Column() {
              Swiper(this.swiperController) {
                ForEach(this.iconList, (item: any) => {
                  Flex({ wrap: FlexWrap.Wrap }) {
                    ForEach(item, (label: any) => {
                      Flex({
                        justifyContent: FlexAlign.SpaceAround,
                        alignItems: ItemAlign.Center,
                        direction: FlexDirection.Column
                      }) {
                        Image(label.icon).width(50).height(50)
                        Text(label.name).margin({ top: 6 }).fontSize(12)
                      }.width('20%').height(80).margin({ bottom: 8 })
                    }, item => JSON.stringify(item))
                  }.width('100%').height(110)
                })
              }
              .cachedCount(2)
              .index(1)
              .autoPlay(true)
              .interval(4000)
              .indicator(true)
              .loop(true)
              .duration(500)
              .itemSpace(0)
              .curve(Curve.Linear)
            }
            .margin({ top: 10 })
            .padding({ left: 12, right: 12 })

            Column() {
              Flex({
                // justifyContent: FlexAlign.Start,
                alignItems: ItemAlign.Start,
                // direction: FlexDirection.Column
              }) {
                // Row() {
                //   Text('大牌数码').fontSize(18).fontWeight(FontWeight.Bold).width('30%')
                //   Text('免息分期').fontSize(14)
                //   Text('更多').fontSize(14)
                // }
                //
                // Row() {
                //   // Image($r('app.media.home'))
                //   Text('￥499.92X12期')
                //   Text('Apple产品')
                // }
                Image($r('app.media.ic_home_2_1')).width('49%').height(100).backgroundColor('#999').borderRadius(12)
                Image($r('app.media.ic_home_2_2')).width('49%').height(100).backgroundColor('#999').borderRadius(12)
              }.width('100%').height(100)

              Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                Image($r('app.media.ic_home_3_1')).width('49%').height(60).backgroundColor('#999').borderRadius(12)
                Image($r('app.media.ic_home_3_2')).width('49%').height(60).backgroundColor('#999').borderRadius(12)
              }.width('100%').height(60).margin({ top: 5 })
            }.padding({ left: 12, right: 12 })
            // 领券专区
            Column() {
              Row() {
                Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
                  Text('领券').fontSize(25).fontColor(Color.Red)
                  Text('专区').fontSize(25).margin({ right: 10 })
                  Text('券后9.9元起').backgroundColor(Color.Yellow)
                }
              }

              Row() {
                Image($r('app.media.ic_home_4_1')).height(100).width('19%')
                Flex({ justifyContent: FlexAlign.End, alignItems: ItemAlign.Center }) {
                  // .backgroundColor(Color.White).margin({bottom: 12}).borderRadius(16)
                  ForEach(this.couponCollectionList, (tabsItem, index) => {
                    Column() {
                      Image(tabsItem.icon)
                        .height(50)
                        .width(50)
                        .backgroundColor(Color.White)
                        .margin({ bottom: 12 })
                        .borderRadius(16)
                      Text(tabsItem.name).fontSize(12).fontColor(Color.Black).margin({ left: 12 })
                      Text(tabsItem.price).fontColor(Color.Red).fontSize(14)
                    }.backgroundColor(Color.Pink)
                  }, tabsItem => JSON.stringify(tabsItem))
                }.width('80%').height(100)
              }
            }.backgroundColor(Color.White).margin({ top: 10 }).padding({ left: 12, right: 12 })
            // 积点兑换
            Column() {
              Row() {
                Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
                  Text('积点').fontSize(25).fontColor(Color.Red)
                  Text('兑换').fontSize(25).margin({ right: 10 })
                  Text('单品低至1元').backgroundColor(Color.Yellow)
                }
              }

              Scroll(this.scroller) {
                Row() {
                  ForEach(this.exchangePointsList, (item: any) => {
                    Flex({
                      alignItems: ItemAlign.Center,
                      direction: FlexDirection.Column }) {
                      Image(item.icon)
                      Text(item.name).fontSize(12).fontColor(Color.Black)
                      Text(item.price).fontColor(Color.Red).fontSize(14)
                    }
                  }, item => JSON.stringify(item))
                }
              }.width('100%').height(120).scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)

            }
            .width('100%')
            .height('20%')
            .backgroundColor(Color.White)
            .margin({ top: 10 })
            .padding({ left: 12, right: 12 })
          }
        }
      }.backgroundColor('#f2f2f2')

      ListItemGroup({ header: this.itemHead() }) {
        ListItem() {
          Column({ space: 2 }) {
            // ColumnSplit() {
            //WaterFlow({ footer: this.itemFoot.bind(this), scroller: this.buildScroller() }) {
            WaterFlow() {
              // LazyForEach(this.popularRecommendationsList, (item: number) => {
              ForEach(this.popularRecommendationsList, (item, index) => {
                FlowItem() {
                  Column() {
                    Image($rawfile(item.icon)).height('30%')
                    if (item.name) {
                      Text(item.name).fontWeight(FontWeight.Bold).fontSize(16)
                    }
                    if (item.price) {
                      Text(`¥ ${item.price}`).width('100%').fontSize(20).fontColor(Color.Red)
                    }
                    if (item.sold) {
                      Text(item.sold).width('100%').fontSize(16)
                    }
                  }.padding(5).onClick(() => {
                    router.pushUrl({
                      url: 'pages/shop/components/page/ShopDetail',
                      params: {
                        param: JSON.stringify(item),
                        id: item.id
                      }
                    })
                  })
                }
                .width(this.itemWidthArray[index])
                .height(this.itemHeightArray[index])
                .backgroundColor(Color.White)
              }, item => JSON.stringify(item))
              // .backgroundColor(this.colors[item % 5])
              // }, item => item)
            }
            .columnsTemplate("1fr 1fr")
            .itemConstraintSize({
              minWidth: 0,
              maxWidth: '100%',
              minHeight: 0,
              maxHeight: '100%'
            })
            .columnsGap(10)
            .rowsGap(5)
            .onReachStart(() => {
              console.info("onReachStart")
            })
            .onReachEnd(() => {
              setTimeout(() => {
                this.popularRecommendationsList.push(
                  {
                    id: '1',
                    icon: 'ic_home_6_1.png',
                    name: '华为（HUAWEI）Mate60 Pro 旗舰手机 12GB+512GB 雅丹黑',
                    price: 7000.00,
                    sold: '已售:100+',
                    specifications: '12G+256G',
                    address: '上海市徐汇区',
                    business: '珀莱雅官方旗舰店',
                    businessId: '1',
                    count: 2,
                    // selected: false,
                  },
                  {
                    id: '2',
                    icon: 'ic_home_6_2.png',
                    name: '汾酒 红盖玻汾 清香型白酒 42度 475mL 6瓶 整箱装',
                    price: 200.10,
                    sold: '已售:200+',
                    specifications: '6瓶',
                    address: '上海市徐汇区',
                    business: '山西汾酒官方旗舰店',
                    businessId: '2',
                    count: 1,
                    // selected: false,
                  },
                  {
                    id: '3',
                    icon: 'ic_home_6_3.png',
                    name: 'Appleipadpro 2022款苹果平板电脑 未使用 海外版 22款ipad pro11寸 灰色 256G WiFi版 未使用 店保一年',
                    price: 400.00,
                    sold: '已售:300+',
                    specifications: '22款ipad pro 11寸 灰色',
                    address: '上海市徐汇区',
                    business: '珀莱雅官方旗舰店',
                    businessId: '1',
                    count: 1,
                    // selected: false,
                  },
                  {
                    id: "4",
                    icon: 'ic_home_6_4.png',
                    name: '三星（SAMSUNG）110英寸 Micro LED自发光全倒装 COB封装大屏无边框智能显示屏 家用巨幕 MNA110MS1ACXXZ 一价无忧',
                    price: 1049.00,
                    sold: '已售:400+',
                    specifications: '110英寸Micro LED显示屏',
                    address: '上海市徐汇区',
                    business: '珀莱雅官方旗舰店',
                    businessId: '1',
                    count: 1,
                  },
                  {
                    id: "5",
                    icon: 'ic_home_6_5.png',
                    name: '三星 SAMSUNG 心系天下 W24 16GB+1TB 纳多灰 附S Pen 超闭合折叠 尊奢铰链 轻型化陶瓷 5G折叠屏手机',
                    price: 159.00,
                    sold: '已售:500+',
                    specifications: '享24期免息',
                    address: '上海市徐汇区',
                    business: '珀莱雅官方旗舰店',
                    businessId: '1',
                    count: 1,
                  },
                  {
                    id: "6",
                    icon: 'ic_home_6_6.png',
                    name: '光明纯牛奶250mL*24盒 家庭量贩装 浓醇营养早餐伴侣',
                    price: 67.80,
                    sold: '已售:600+',
                    specifications: '[经典纯奶] 纯牛奶250ml*24',
                    address: '上海市徐汇区',
                    business: '珀莱雅官方旗舰店',
                    businessId: '1',
                    count: 1,
                  }
                )
              }, 2000)
            })
            .backgroundColor(0xFAEEE0)
            .width('100%')
            .height('90%')
            .layoutDirection(FlexDirection.Column)
          }
        }
      }.backgroundColor('#f2f2f2')
    }
    .linearGradient({
      direction: GradientDirection.Bottom, // 渐变方向
      repeating: false, // 渐变颜色是否重复
      colors: [['#f2f2f2', 0.3]] // 数组末尾元素占比小于1时满足重复着色效果
    })
    .sticky(StickyStyle.Header)
    .scrollBar(BarState.Auto)
    .offset({ x: 0, y: `${RefreshConst.offsetY}${RefreshConst.LIST_OFFSET_UNIT}` })
    .onScrollIndex((start: number, end: number) => {
      // 监控滑动的index和当前List值是否到底
      RefreshConst.startIndex = start;
      RefreshConst.endIndex = end;
    })
  }

  build() {
    Column() {
      PageTitle({ title: '云闪付商城' })
      this.homeLayout()
    }
    .width('100%')
    .height('100%')
    .onTouch((event: TouchEvent | undefined) => {
      if (event) {
        // listTouchEvent(event);
      }
    })
  }
}