import router from '@ohos.router'
import {GoodsItem} from '../../../pages/shop/types'
@Component
export default struct DisplayGoodsItemStruct {
  @ObjectLink item:  GoodsItem
  build() {
    Column() {
      Image($rawfile(this.item.icon)).height('30%')
      if (this.item.name) {
        Text(this.item.name).fontWeight(FontWeight.Bold).fontSize(16)
      }
      if (this.item.price) {
        Text(`¥ ${this.item.price}`).width('100%').fontSize(20).fontColor(Color.Red)
      }
      if (this.item.sold) {
        Text(this.item.sold).width('100%').fontSize(16)
      }
    }.padding(5)
    // .onClick(() => {
    //   router.pushUrl({
    //     url: 'pages/shop/components/page/ShopDetail',
    //     params: {
    //       param: JSON.stringify(this.item),
    //       id: this.item.id
    //     }
    //   })
    // })
  }
}