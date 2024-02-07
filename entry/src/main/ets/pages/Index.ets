import Home from '../views/Home';
import My from '../pages/My';
import ShopCart from '../views/ShopCart';
import Category from '../views/GoodsList/GoodsList'
import promptAction from '@ohos.promptAction';
import {ShoppingData} from '../types'

@Entry
@Component
export default struct TabsBar {
  @State currentIndex: number = 1;
  controller: TabsController = new TabsController()

  getColor(idx) {
    return this.currentIndex === idx ? $r('app.color.dark_red') : $r('app.color.title_color')
  }
  @Builder TabBuilder(index: number, icon: Resource, name: string) {
    if (index === 2) {
      Badge({
        count: 1,
        position: BadgePosition.RightTop,
        style: { badgeSize: 16, badgeColor: $r('app.color.dark_red') }
      }) {
        Column(){
          Image(icon).width(26).fillColor(this.getColor(index))
            .margin({bottom: 5})
          Text(name)
            .fontColor(this.getColor(index))
            .fontSize(14)
        }.width('100%').height('100%')
        .margin({bottom: 15}).justifyContent(FlexAlign.Center)
      }.width(50).height('90%').margin({ left: 15, right: 11 })
    } else {
      Column() {
        Image(icon).width(26).fillColor(this.getColor(index))
          .margin({bottom: 5})
        Text(name)
          .fontColor(this.getColor(index))
          .fontSize(14)
      }
      .width('100%').height('100%').margin({bottom: 15}).justifyContent(FlexAlign.Center)
    }

  }

  @Builder TabBuilder2(index: number) {
    Column() {
      if (index === 2) {
        Badge({
          value: '',
          style: { badgeSize: 6, badgeColor: '#FA2A2D' }
        }) {
          Image($r('app.media.home'))
            .width(24)
            .height(24)
        }
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
      } else {
        Image($r('app.media.customer_fill'))
          .width(24)
          .height(24)
          .margin({ bottom: 4 })
      }
      Text('Tab')
        .fontColor('#182431')
        .fontSize(10)
        .fontWeight(500)
        .lineHeight(14)
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }

  build() {
    // Tabs() {
    //   TabContent()
    //     .tabBar(this.TabBuilder2(0))
    //   TabContent()
    //     .tabBar(this.TabBuilder2(1))
    //   TabContent()
    //     .tabBar(this.TabBuilder2(2))
    //   TabContent()
    //     .tabBar(this.TabBuilder2(3))
    // }
    // .width('100%')
    // .height(56)
    // .backgroundColor('#F1F3F5')

    Tabs({controller: this.controller, index: 2}) {
      TabContent() {
        Home()
      }.tabBar(this.TabBuilder(0, $r('app.media.home'), '首页'))
      TabContent() {
        Category()
      }.tabBar(this.TabBuilder(1, $r('app.media.category'), '全部宝贝'))
      TabContent() {
        ShopCart()
      }.tabBar(this.TabBuilder(2, $r('app.media.cart_empty_fill'), '购物车'))
      TabContent() {
        My()
      }.tabBar(this.TabBuilder(3, $r('app.media.customer_fill'), '我的'))

    }
    .barHeight(50)
    .barPosition(BarPosition.End)
    .barMode(BarMode.Fixed)
    .barWidth('100%')
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .vertical(false)
  }
}