import PageTitle from '../../components/PageTitle';
import router from '@ohos.router';
import { shopCartData2 } from '../shop/mockData'
import TaskInfoApi from '../../common/database/tables/ShopCarInfoApi'
import promptAction from '@ohos.promptAction';
import WebDetail from './components/WebDetail'

@Entry
@Component
struct ShopDetail {
  private scroller: Scroller = new Scroller();
  @State shopDetailModel: any = {}
  @State matched: boolean = false;
  @State arr: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']

  aboutToAppear() {
    const params = router.getParams()
    let id = '';
    if (!params) {
      id = '1'
    }else {
      id = (params as any).id
    }

    // let id = 1;
    const matched = shopCartData2.find(item => item.id === id)
    if (matched) {
      this.matched = true;
      this.shopDetailModel = matched
    }
  }

  build() {
    Column() {
      PageTitle({ title: '云闪付商城 商品详情' })
      Column() {
        Flex({
          alignItems: ItemAlign.Start,
          // direction: FlexDirection.Column
        }) {
          if (this.matched) {
            Scroll(this.scroller) {
              Column(){
                Flex({
                  // justifyContent: FlexAlign.Start,
                  alignItems: ItemAlign.Start,
                  direction: FlexDirection.Column
                }) {
                  Image($rawfile(this.shopDetailModel.icon))
                  // .width('100%').height('30%')
                  // .backgroundColor(Color.Yellow);
                  Row() {
                    Text(`¥ ${this.shopDetailModel.price}`)
                      .fontSize(20).fontWeight(FontWeight.Bold).fontColor($r('app.color.dark_red')).width('60%')
                    Text('订阅').width('15%').fontSize(14)
                    Text(this.shopDetailModel.sold).fontSize(14)
                  }.width('100%').height(50).margin({ left: 20 })
                  Row() {
                    Text(this.shopDetailModel.name).fontWeight(FontWeight.Bold)
                  }.width('100%').height(50).margin({ left: 20 })
                  Image($r("app.media.ic_home_1")).width('100%')
                  // .height('10%')
                  // .backgroundColor(Color.Yellow);
                  Row() {
                    Text('规格').width('20%')
                    Text(this.shopDetailModel.specifications).width('70%')
                    Image($r('app.media.right')).width(16)
                    // Image($r('app.media.right')).margin({left:100})
                  }.width('100%')
                  .height('50')
                  .margin({ left: 10 })

                  Row() {
                    Text('配送').width('20%')
                    Text(this.shopDetailModel.address).width('70%')
                    Image($r('app.media.right')).width(16)
                    // Image($r('app.media.right')).margin({left:100})
                  }.width('100%')
                  .height(50)
                  .margin({ left: 10 })
                  // .backgroundColor(Color.Green)
                }
                .height('90%')
                WebDetail()
              }
              // Text(`1`).height(200).width('100%').fontWeight(FontWeight.Bold)
              //   .textAlign(TextAlign.Center)
              //   .border({width: {bottom: 1}, color: Color.Gray, style: BorderStyle.Solid})
              //   .backgroundColor(Color.Orange)
              // Text(`2`).height(200).width('100%').fontWeight(FontWeight.Bold)
              //   .textAlign(TextAlign.Center)
              //   .border({width: {bottom: 1}, color: Color.Gray, style: BorderStyle.Solid})
              //   .backgroundColor(Color.Orange)
              // Text(`3`).height(200).width('100%').fontWeight(FontWeight.Bold)
              //   .textAlign(TextAlign.Center)
              //   .border({width: {bottom: 1}, color: Color.Gray, style: BorderStyle.Solid})
              //   .backgroundColor(Color.Orange)

            }
            .scrollable(ScrollDirection.Vertical)
            // .scrollBar(BarState.On)
            // .scrollBarColor(Color.Gray)
            // .scrollBarWidth(30)
            // .height('100%')
            // .margin({top: -40})
          } else {
            Text('未找到对应商品').textAlign(TextAlign.Center)
              .width("100%").height('100%')
              .fontSize(26).fontWeight(FontWeight.Bold)
          }

        }.height('85%')
      }
      Row() {
        Flex({
          justifyContent: FlexAlign.SpaceAround,
          direction: FlexDirection.Row,
          alignItems: ItemAlign.Center
        }) {
          Image($r('app.media.ic_shop')).height(30)

          Image($r('app.media.ic_shop_customerService')).height(30)

          Image($r('app.media.ic_shop_shopCar')).height(30).onClick(() => {
            router.pushUrl({
              url: 'pages/ShopCartPage',
              params: {
                // param: item
              }
            })
          })

          Row() {
            Button('加入购物车').backgroundColor('#fa0').borderRadius(1).width('30%').onClick(() => {
              TaskInfoApi.insert(this.shopDetailModel).then(res => {
                promptAction.showToast({ message: '加入购物车成功' })
              }).catch(e => {
                promptAction.showToast({ message: e.message })
              })
            })
            Button('立即购买')
              .backgroundColor(Color.Red)
              .borderRadius(1)
              .width('30%')
              .margin({ left: 5 })
              .onClick(() => {

                let price = 0
                if(this.shopDetailModel.count){
                  price = this.shopDetailModel.price * this.shopDetailModel.count
                }else{
                  this.shopDetailModel.count = 1
                  price = this.shopDetailModel.price
                }
                const data = {
                  ...this.shopDetailModel,
                  children:[{...this.shopDetailModel}]
                }
                router.pushUrl({
                  url: 'pages/shop/components/page/OrderSure',
                  params: {
                    list:[data],
                    sum:price ,
                    units: this.shopDetailModel.count
                  }
                })
              })
          }
        }.width('100%')
        .height(40)
      }.position({y: '100%', x: '0%'})
      .translate({y: -40})
      .backgroundColor('white')
    }
    .width('100%')
    .height('100%')
  }
}