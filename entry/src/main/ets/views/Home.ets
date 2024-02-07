
import hilog from '@ohos.hilog';
import { SearchComponent } from '../mycomponent/SearchComponent'
import { SelectComponent } from '../mycomponent/SelectComponent'
import router from '@ohos.router';
import display from '@ohos.display';
import { CommonConstants } from '../common/constants/CommonConstants';
@Component
@Preview
export default struct Home {

  @State swidth:number = display.getDefaultDisplaySync().width;
  private listController: Scroller = new Scroller();
  controller: TextInputController = new TextInputController()
  private swiperController: SwiperController = new SwiperController()
  private swiperColumnController: SwiperController = new SwiperController()
  private swiperImageController: SwiperController = new SwiperController()


  @State topIconList: any = [
    { icon: $r('app.media.pay'), name: '收付款' ,rui:''},
    { icon: $r('app.media.cx2x'), name: '出行' ,rui:''},
    { icon: $r('app.media.sys2x'), name: '扫一扫' ,rui:''},
    { icon: $r('app.media.kgl2x'), name: '卡管理' ,uri:'pages/Card'},
  ]

  @State iconList: any = [
    [
      { icon: $r('app.media.ccm2x'), name: '乘车码', uri:'' },
      { icon: $r('app.media.xfq2x'), name: '消费券', uri:'' },
      { icon: $r('app.media.subway2x'), name: '地铁', uri:''},
      { icon: $r('app.media.lkh2'), name: '乐开花', uri:''},
      { icon: $r('app.media.Frame2x'), name: '借款', uri:'' },
      { icon: $r('app.media.sc2x'), name: '商城', uri:'pages/shop/ShopHome' },
      { icon: $r('app.media.zz2x'), name: '转账', uri:''},
      { icon: $r('app.media.xfzl2x'), name: '寻福', uri:''},
      { icon: $r('app.media.cardrepay'), name: '还款', uri:''},
      { icon: $r('app.media.cz2x'), name: '信用卡', uri:''},
    ],
    [
      { icon: $r('app.media.lkh2'), name: '信用', uri:''},
      { icon: $r('app.media.lkh2'), name: '无界卡', uri:''},
      { icon: $r('app.media.lkh2'), name: '查卡', uri:''},
      { icon: $r('app.media.lkh2'), name: '贷款', uri:''},
      { icon: $r('app.media.lkh2'), name: '充话费', uri:''},
      { icon: $r('app.media.lkh2'), name: '缴费', uri:''},
      { icon: $r('app.media.lkh2'), name: '活期+', uri:''},
      { icon: $r('app.media.lkh2'), name: '车生活', uri:''},
      { icon: $r('app.media.lkh2'), name: '医保', uri:''},
      { icon: $r('app.media.lkh2'), name: '更多', uri:''},
    ],
  ]

  @State newsList : any = [
    {title:'优惠助手1',notice:'优惠通知', date:'昨天'},
    {title:'优惠助手2',notice:'优惠通知', date:'11月26日'},
    {title:'优惠助手3',notice:'优惠通知', date:'昨天'},
    {title:'优惠助手4',notice:'优惠通知', date:'11月26日'},
    {title:'优惠助手5',notice:'优惠通知', date:'昨天'},
    {title:'优惠助手6',notice:'优惠通知', date:'11月26日'}

  ]

  @Builder itemHead() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      Column(){
        SelectComponent()
      }
      Column(){
        SearchComponent()

      }.margin({
        left:5
      })
      Column() {
        Image($r('app.media.switch2x')).fillColor('#fff').width(30).height(30)
      }
     .margin({left: 12, right: 12}).borderRadius(32)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      Column() {
        Image($r("app.media.add_circle2x")).fillColor('#fff').objectFit(ImageFit.Auto).width(30).height(30)
      }.borderRadius(32).alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.Center)
    }.padding({right: 12, left: 12}).backgroundColor('#ED171F')
  }

  @Builder homeLayout() {
    List({scroller:this.listController}){
      ListItemGroup({ header:this.itemHead() }){
        ListItem(){
          Column() {
            Flex({
              justifyContent: FlexAlign.SpaceAround,
              alignItems: ItemAlign.Start
            }) {
              Flex({
                justifyContent: FlexAlign.SpaceAround,
                alignItems: ItemAlign.Start,
                wrap: FlexWrap.Wrap,
                direction: FlexDirection.Row
              }) {
                Row(){
                  Flex({
                    justifyContent: FlexAlign.SpaceAround,
                    alignItems: ItemAlign.Start,
                    wrap: FlexWrap.Wrap,
                    direction: FlexDirection.Row
                  }){
                    ForEach(this.topIconList, (tabsItem, index) => {
                      //第一排图标
                      Column() {
                        Image(tabsItem.icon)
                          .width(50)
                          .height(50)
                          .borderRadius(30)
                          .margin({
                            top: 5
                          })
                          .onClick(() => {
                            router.pushUrl({
                              url:tabsItem.uri
                            })
                          })
                        Text(tabsItem.name).fontColor('#fff').fontSize(16)
                      }
                    }, tabsItem => JSON.stringify(tabsItem))
                  }
                }.width('100%').backgroundColor('#ED171F')

                Column() {
                  Stack(){
                    Image($r('app.media.head_background')).width('100%')
                    Column(){
                      Row(){
                        Text('2023 鸿蒙系统').fontSize(34)
                          .fontWeight(26).textAlign(TextAlign.Start).width('100%').padding({
                          left:40
                        }).fontColor('#fff')
                      }.margin({top:10})
                      Row(){
                        Text('最新系统抢先版').fontSize(21)
                          .fontWeight(26)
                          .textAlign(TextAlign.Start)
                          .width('100%').padding({
                          left:40
                        })
                          .fontColor('#fff')
                      }
                    }
                  }


                }
                .zIndex(1)
              }
            }
            .borderRadius({
              bottomLeft:50,
              bottomRight:50
            })
            .clip(true)

            Column() {
              Swiper(this.swiperController) {
                ForEach(this.iconList, (iconItem, index) => {
                  Flex({ wrap: FlexWrap.Wrap }) {
                    ForEach(iconItem, (icon, index) => {
                      Flex({
                        justifyContent: FlexAlign.SpaceAround,
                        alignItems: ItemAlign.Center,
                        direction: FlexDirection.Column
                      }) {
                        if (icon.uri === undefined || icon.uri === '') {
                          Image(icon.icon).width(50).height(50)
                        } else {
                          Image(icon.icon).width(50).height(50).onClick(() => {
                            router.pushUrl({ url: icon.uri })
                          })
                        }
                        Text(icon.name).width(50).height(50).textAlign(TextAlign.Center)
                      }.width('20%')
                    }, icon => JSON.stringify(iconItem))
                  }.width('100%').margin({
                    top: 5
                  })
                })
              }
              .autoPlay(true)
              .interval(4000)
              .indicator(true)
              .loop(true)
              .itemSpace(0)
              .curve(Curve.Linear)
            }

            Column() {
              Swiper(this.swiperColumnController) {
                Flex({ wrap: FlexWrap.Wrap }) {
                  ForEach(this.newsList, (newsItem, index) => {
                    Flex({
                      justifyContent: FlexAlign.SpaceAround,
                      alignItems: ItemAlign.Center,
                      direction: FlexDirection.Row
                    }) {
                      Text(newsItem.title + ":").height(40).textAlign(TextAlign.End).padding({ left: 10 })
                      Text(newsItem.notice).height(40).width(100).textAlign(TextAlign.Start)
                      Text(newsItem.date).height(40).width(100).textAlign(TextAlign.Start)
                      Image($r("app.media.down2x")).height(20).width(20).margin({
                        right:5
                      })
                    }.height('50%')

                  }, newsItem => JSON.stringify(newsItem))
                }
                .layoutWeight('94%')
                .height(100)
                .backgroundColor('#fff')
                .borderRadius(32)
                .width('90%')
                .borderWidth(1)
                .borderColor('#eee')
              }
              .vertical(true)
              .indicator(false)
              .loop(true)
              .autoPlay(true)
              .cachedCount(1)
            }

            Column() {
              Image($r('app.media.pict_01')).width('90%').borderRadius(16).margin({
                top: 10
              })
            }

            Column() {
              Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                Image($r('app.media.jl_center')).width('49%').objectFit(ImageFit.Fill).borderRadius(16)
                Image($r('app.media.xb')).width('49%').objectFit(ImageFit.Fill).borderRadius(16)
              }.width('95%').height(100).margin({ top: 24 })

              Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                Image($r('app.media.hq')).width('24%').borderRadius(16)
                Image($r('app.media.yhr')).width('24%').borderRadius(16)
                Image($r('app.media.stsq')).width('24%').borderRadius(16)
                Image($r('app.media.hqg')).width('24%').borderRadius(16)
              }.width('95%').height(100).margin({ top: 24 })

              Row(){
                Text('本地专区').fontSize(30).fontWeight(400)
              }.justifyContent(FlexAlign.Start)
              .width('90%')

              Flex({ direction:FlexDirection.Column,justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                Row(){
                  Flex({justifyContent: FlexAlign.SpaceBetween}){
                    Image($r('app.media.bd1_2x')).width('49%').objectFit(ImageFit.Fill).borderRadius(12)
                    Image($r('app.media.bd2_2x')).width('49%').borderRadius(12)
                  }
                }.margin({
                  bottom:10
                })
                Row(){
                  Flex({justifyContent: FlexAlign.SpaceBetween}){
                    Image($r('app.media.bd3_2x')).width('49%').borderRadius(12)
                    Image($r('app.media.bd4_2x')).width('49%').borderRadius(12)
                  }
                }
              }.width('95%').margin({ top: 24 })
            }.padding({ left: 12, right: 12 })

          }
        }
        .backgroundColor('#f2f2f2')
      }
    }
    .scrollBar(BarState.Auto)
    .sticky(StickyStyle.Header)
  }

  build() {
    Column() {
      this.homeLayout()
    }
    .width('100%')
    .height('100%')
  }
}

