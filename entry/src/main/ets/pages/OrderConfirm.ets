import PageTitle from '../components/PageTitle'
import { OrderSureData } from '../viewmodel/OrderSureData'
import router from '@ohos.router';
import prompt from '@ohos.promptAction';
import {GoodsItem, Shop} from './shop/types'
import {shopCartData} from './shop/mockData'
import StoreHeader from '../components/StoreHeader'

@Extend(Text) function right() {
  .fontSize(16).fontColor($r('app.color.dark_red'))
}
@Extend(Text) function left() {
  .width(82).fontWeight(FontWeight.Bold)
  .textAlign(TextAlign.End)
}

@Extend(Row) function row() {
  .justifyContent(FlexAlign.SpaceBetween).width('100%')
  .margin({bottom: 8})
}

@Component
struct GoodsItemStruct {
  @ObjectLink goods: GoodsItem;
  build() {
    Row() {
      Image($rawfile(this.goods.icon))
        .width(100)
        .height(100).margin({right: 16})
      Column() {
        Text(this.goods.name)
          .textOverflow({
            overflow:TextOverflow.Ellipsis
          })
          .fontWeight(FontWeight.Bold)
          .maxLines(3).margin({bottom: 8})
        Text(this.goods.specifications)
          .backgroundColor($r('app.color.shallow_gray'))
        .margin({bottom: 5})
          .padding(4)
          // .margin({top:5,bottom:5})
        Row(){
          Text('¥' + this.goods.price)
            .fontSize(24)
            .fontColor($r('app.color.dark_red'))
          Text('x'+this.goods.count)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

      }.width('100%')
      .layoutWeight(1)
      // .height(100)
      .alignItems(HorizontalAlign.Start)
    }.width("100%")
  }
}
@Entry
@Component
struct OrderConfirm {
  @State title: string = '确认订单'
  @State price: number  = 0
  @State count: number  = 0
  @State isMore: boolean = false
  @State isShow: boolean = false
  @State addressData: OrderSureData = null;
  @State dataList :object[] = []
  @State allDataList :object[] = []
  @State showDataList :Shop[] = shopCartData
  private scroller: Scroller = new Scroller();



  @Builder address() {
    Column() {
      Column() {
        Row() {
          Image($r('app.media.positioning')).width(30).height(30).fillColor('red')
          Text('张18656566565').fontWeight(700)
        }
        Text(`上海市徐汇区漕河泾开发区科汇大厦`).margin({left:22})
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .backgroundColor('#fff')
    .margin({ bottom: 15 })
    .borderRadius(10)
    .padding({top:10,bottom:10})
  }

  @Styles left() {
    .width(100).backgroundColor('red')
  }

  @Builder footer() {
    Column() {
      Text('订单金额明细').fontSize(20)
        .fontWeight(FontWeight.Bolder).margin({bottom: 15})
      Row() {
        Text('商品金额').left()
        Text(`¥${this.price}`).right()
      }.row()
      Row() {
        Text('运费').left()
        Text(`¥0`).right()
      }.row().margin({bottom: 25})
      Row() {
        Text('合计').left()
        Text(`¥0`).right().fontSize(26)
      }.row()
    }
    .width('100%')
    .height(160)
    .backgroundColor('#fff')
    .alignItems(HorizontalAlign.Start)
    .margin({ bottom: 15 ,top:15})
    .borderRadius(10)
    .padding({left:18,right:18, top: 10, bottom: 10})
    Row() {
      Text('支付优惠')
        .fontSize(20)
        .fontWeight(FontWeight.Bolder)
        .width(100)
      Text('实际优惠以提交订单后支付时选卡为准')
        .fontColor('#bbb')
        .fontSize(12)
    }
    .height(50)
    .width('100%')
    .backgroundColor('#fff')
    .borderRadius(10)
    .padding({left:20})

    Row() {
      Text('提示：支付优惠在支付选卡时展示，商品最终价格以提交订单后支付选卡为准，购买后可在订单中心开票')
        .fontColor('#aaa')
    }.margin({top:10})
  }

  aboutToAppear() {
    if(router.getParams()){
      let list = router.getParams()['list']
      this.count = router.getParams()['units'] || 0
      this.price = router.getParams()['sum'] || 0
      if(list && list.length>0){
        if(list.length>1 || list[0].children.length>1){
          this.isShow = true
        }else{
          this.isShow = false
        }
        this.allDataList = [...list]

        this.dataList.push(list[0])
        this.showDataList.push(list[0])
      }
    }


    // this.price = shopDetailModel.count * shopDetailModel.price + ''
  }

  getMore() {
    // if(!this.isMore){
    //   this.showDataList = [...this.allDataList]
    // }else{
    //   this.showDataList = [...this.dataList]
    // }

    this.isMore = !this.isMore

  }

  build() {
    Column() {
      //头部区域
      Column() {
        PageTitle({ title: this.title })
      }
      //中间商品区
      Column() {
        Scroll() {
          Column() {
            //商品信息
            Column() {
              List() {
                ListItemGroup({ header: this.address() }) {
                  ForEach(this.showDataList,
                    (item) => {
                      ListItem() {
                        // StoreItem({item})
                        Column(){
                          StoreHeader({storeName: item.business})
                          ForEach(item.children, child => {
                            GoodsItemStruct({goods: child})
                          })
                          // Row(){
                          //   if(!this.isMore){
                          //     this.main([item.children[0]])
                          //   }else{
                          //     this.main(item.children)
                          //   }
                          // }
                        }
                        .padding({right:10, left: 10})

                      }
                      .backgroundColor('#fff')
                      .borderRadius({topLeft:10,topRight:10})
                    }
                  )
                  ListItem() {
                    if(this.isShow){
                      if (!this.isMore) {
                        Text('加载更多 v')
                          .fontColor('#bbb')
                          .onClick(() => {
                            this.getMore()
                          })
                      } else {
                        Text('收起更多 ^')
                          .fontColor('#bbb')
                          .onClick(() => {
                            this.getMore()
                          })
                      }
                    }else{
                    }
                  }
                  .width('100%')
                  .height(40)
                  .backgroundColor('#fff')
                  .borderRadius({bottomLeft:10,bottomRight:10})
                  this.footer()
                }
              }
              .margin({ bottom: 10 })

            }
            .width('95%')
            // .backgroundColor('#fff')
            .margin({ bottom: 15 })

          }.width('100%').height('100%')
        }
      }
      .margin({top:10})
      .layoutWeight(1)

      //底部按钮
      Column() {
        Row() {
          Text(){
            Span(`共${this.count}件，预估到手合计`)
            Span('¥').fontColor($r('app.color.dark_red'))
            Span(`${this.price}`).fontSize(24).fontColor($r('app.color.dark_red'))
          }
          .padding({right:10})
            .fontWeight(1)
          Button('提交订单')
            .type(ButtonType.Normal)
            .height(50)
            .width(100)
            .backgroundColor($r('app.color.dark_red'))
            .onClick(()=>{
              prompt.showToast({
                message: '订单提交成功'
              })
            })

        }.height('100%').width('100%')
        .justifyContent(FlexAlign.End)
      }.height(50)
      .width('100%')
      .backgroundColor('white')

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('app.color.shallow_gray'))
  }
}
