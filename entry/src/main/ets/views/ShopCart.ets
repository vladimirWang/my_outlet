import router from '@ohos.router';
import PageTitle from '../components/PageTitle';
import {Shop, GoodsItem} from '../pages/shop/types'
import ShopCartItem from '../pages/shop/components/page/ShopCartItem'
import {shopCartData, shopCartData2} from '../pages/shop/mockData'
import {add, multiply, divide, subtract } from '../util/math'
import promptAction from '@ohos.promptAction';

@Extend(Text) function btnStyle(bgColor, ftColor) {
  .padding({left: 10, top: 5, bottom: 5, right: 10})
  .backgroundColor(bgColor).fontColor(ftColor)
}

@Component
struct toggleBtn {
  @Prop text: string;
  @Prop active: boolean;
  @Prop activeColor: string;
  build() {
    Button({type: ButtonType.Normal}){
      Text(this.text)
        .fontSize(14)
        .fontColor(this.active? 'white': $r('app.color.dark_red'))
    }.width('100%').height('100%')
    .border({
      color: $r('app.color.dark_red'),
      width: 1,
      style: BorderStyle.Solid
    })
    .backgroundColor(this.active ? $r('app.color.dark_red'): 'white')

  }
}
@Preview
@Component
export default struct ScrollExample {
  scroller: Scroller = new Scroller()
  @State isAllSelected: boolean = false;
  @State shopCartDetails: Shop[] = []
  @State choosed: Shop[] = []
  @State units: number = 0;
  @State sum: number = 0;
  @State isEdit: boolean = true;

  // 监听选中商品操作
  onChange() {
    const tmp = this.shopCartDetails.reduce((a, c) => {
      // 找出该店铺中已选的商品
      const {children, ...rest} = c;
      const selected = children.filter(item => item.selected)
      if (selected.length) {
        a.push({
          ...rest,
          children: selected
        })
      }
      // 有已选商品的push到 a
      return a;
    }, [])

    // 只记录已选商品，传给确认订单
    this.choosed = tmp;

    let units = 0, sum = 0;
    for (let i = 0;i < tmp.length; i++) {
      const children = tmp[i].children
      for (let j = 0;j < children.length; j++) {
        units += children[j].count;
        sum = add(sum, multiply(children[j].count, children[j].price))
      }
    }
    this.isAllSelected = this.shopCartDetails.every((shop: Shop) => {
      return shop.children.every((goods: GoodsItem) => goods.selected)
    })
    this.units = units;
    this.sum = sum;
  }
  makeGroup2(data: GoodsItem[]): Shop[] {
    if (data == null || data.length == 0) {
      return [];
    }
    const res = data.reduce((a, c: GoodsItem) => {
      const idx = a.findIndex(item => item.businessId === c.businessId)
      if (idx > -1) {
        a[idx].children.push(c)
      } else {
        a.push(new Shop(c.business, c.businessId, [c], false))
      }
      return a;
    }, [])
    return res;
  }

  calculateAllSelected(data: Shop[]): boolean {
    return data.every(item => {
      return item.children.every(child => child.selected)
    })
  }

  async aboutToAppear() {
    // this.shopCartDetails  = shopCartData;
    const groupData = this.makeGroup2(shopCartData2)
    this.shopCartDetails = groupData
    this.isAllSelected = this.calculateAllSelected(groupData)
    this.onChange()
  }

  // 去确认订单页面
  confirm(): void {
    console.log('1')
    router.pushUrl({
      url: 'pages/shop/components/page/OrderSure',
      params: {
        list: this.choosed,
        sum: this.sum,
        units: this.units
      }
    })
  }

  handleDelete(): void {
    const newShops = this.shopCartDetails.reduce((a, c) => {
      const {children, ...rest} = c;
      const notSeletedItems = children.filter((goods: GoodsItem) => !goods.selected)
      console.log(JSON.stringify(notSeletedItems), '--seletedItems--')
      // notSeletedItems.length === children.length
      const newShop = new Shop(rest.business, rest.businessId, notSeletedItems, true)
      a = a.concat(newShop)
      // a.push()
      return a;
    }, [])
    this.shopCartDetails = newShops
    // this.shopCartDetails = []
    // setTimeout(() => {
    //   this.shopCartDetails = newShops
    // }, 10)

    // this.shopCartDetails.forEach((item: Shop) => {
    //   const {children, businessId, business} = item;
    //   // const seletedItems = children.filter((goods: GoodsItem) => !goods.selected)
    //   // const newShop = new Shop(business, businessId, seletedItems)
    //   // item = newShop
    // })
  }

  @Builder toolBar() {
    Column() {
      Row(){
        Row() {
          Text(this.isAllSelected ? "全不选": "全选")
            .backgroundColor($r('app.color.dark_red'))
            .fontColor('white')
            .width(60)
            .textAlign(TextAlign.Center)
            .height('100%')
            .onClick(() => {
            const newState = !this.isAllSelected
            this.isAllSelected = newState
            this.shopCartDetails.forEach(shop => {
              shop?.children.forEach(goods => {
                goods.selected = newState
              })
            })
          })
        }.height(40)
        if (this.isEdit) {
          Row() {
            Text('移入收藏夹').btnStyle(Color.Orange, Color.White)
            Text('删除').btnStyle($r("app.color.dark_red"), Color.White).onClick(() => {
              this.handleDelete()
            })
          }
        } else {
          Column() {
            Text(`已选 ${this.units} 件`).fontSize(12)
            Text(`合计¥ ${this.sum}`).fontSize(12).fontColor($r('app.color.dark_red'))
          }

          Button('去结算')
            .backgroundColor($r('app.color.dark_red'))
            .type(ButtonType.Normal)
            .width(80)
            .fontSize(14)
            .onClick(() => {
              this.confirm()
            })
        }

      }.width('90%').justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }.height(54)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .backgroundColor('white')
    // .padding({ left: 20, right: 20 })
  }

  @Builder addressChoose() {
    Row() {
      Image($r("app.media.ic_position1")).height(20).margin({right: 10})
      Text('请先选择地址').flexGrow(1)
      Image($r('app.media.right')).width(18)
    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)
    .width('100%').height(48).padding({ right: 20, left: 20 })
    .margin({bottom: 5})
    .backgroundColor('white')
  }

  @Builder homeLayout() {
    Column({ space: 2 }) {
      ForEach(this.shopCartDetails, (item, index) => {
        ShopCartItem({item: item as Shop, updateSummary: () => {
          this.onChange();
        }, deleteFn: (index2) => {
          this.shopCartDetails.forEach((ite, idx) => {
            if (index === idx) {

              ite.children.splice(index2, 1)
            }
          })
        }}).backgroundColor('white')
      }, (item: Shop) => item.businessId)
    }.padding({bottom: 110})
    // .linearGradient({
    //   direction: GradientDirection.Bottom, // 渐变方向
    //   repeating: false, // 渐变颜色是否重复
    //   colors: [['#e9614d', 0.7], ['#f2f2f2', 0.3]] // 数组末尾元素占比小于1时满足重复着色效果
    // })
    // .height('80%')
  }
  build() {
    Column(){
      PageTitle({ title: '购物车' })
      Scroll(this.scroller) {
        //
        Column() {
          Row() {
            Text('编辑').fontColor(Color.White).fontSize(20)
              .padding({left: 10, right: 10, top: 5, bottom: 5})
            .onClick(() => {
              this.isEdit = !this.isEdit
            })
          }.justifyContent(FlexAlign.End)
          .width('100%')
          // ForEach(this.arr, (item) => {
          //   Text(item.toString())
          //     .width('90%')
          //     .height(150)
          //     .backgroundColor(0xFFFFFF)
          //     .borderRadius(15)
          //     .fontSize(16)
          //     .textAlign(TextAlign.Center)
          //     .margin({ top: 10 })
          // }, item => item)
          this.addressChoose()
          this.homeLayout()
        }.width('96%').padding({left: 4, right: 4})
        .alignItems(HorizontalAlign.Center)
      }
      .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
      .scrollBar(BarState.On)  // 滚动条常驻显示
      .scrollBarColor(Color.Gray)  // 滚动条颜色
      .scrollBarWidth(3) // 滚动条宽度
      .edgeEffect(EdgeEffect.None)
      Column(){
        this.toolBar()
      }.width('100%')
      .position({y: '100%'})
      .translate({y: -45})
    }.justifyContent(FlexAlign.Start).height('100%')
    .backgroundColor($r('app.color.dark_red'))
  }
}