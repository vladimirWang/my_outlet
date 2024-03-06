import StoreHeader from '../../../../components/StoreHeader'
import GoodsItemStruct from './GoodsItemStruct'
import {Shop} from '../../types'
import promptAction from '@ohos.promptAction';
import {sleep} from '../../../../common/utils/helper';
import {GoodsItem} from '../../types'

@Component
export default struct ShopCartItem {
  @ObjectLink item: Shop;

  updateSummary: () => void;
  deleteFn: (index2: number) => void;

  build() {
    Column() {
      Row() {
        Flex({ wrap: FlexWrap.Wrap }) {
          // 店铺名称
          Row() {
            CheckboxGroup({ group: this.item.businessId })
              .selectedColor($r('app.color.dark_red'))
            // .selectAll(this.allSelected)
            StoreHeader({storeName: this.item.isChanged + this.item.business})
            // Text(this.item.isChanged + '').fontSize(20).fontColor(Color.Orange)
          }.width('95%').margin({ left: 15, top: 15 })
        }
      }
      ForEach(this.item.children, (item2: GoodsItem, index2) => {
        GoodsItemStruct({
          goods: item2 as GoodsItem,
          businessId: this.item.businessId,
          updateSummary: () => {
            this.updateSummary();
          },
          removeGoodsItem: async () => {
            await sleep(500)
            this.item.children = this.item.children.filter((_, idx2) => {
              return idx2 !== index2;
            });
            // promptAction.showToast({message: index2 + ''})
            // this.item.children.splice(index2, 1)
            // const newGoods = new GoodsItem(
            //   '1',
            //   '珀莱雅官方旗舰店',
            //   '10',
            //   '梅西0000999',
            //   2000,
            //   '已售:100+',
            //   '12G+256G',
            //   '上海市徐汇区',
            //   2,
            //   'ic_home_6_1.png',
            //   true
            // )
            // this.item.children.push(newGoods)
            // this.item.children = []
            // this.item.business = "hello world"
            // this.deleteFn(index2)
            this.updateSummary();
          }
        })
      }, (item2: GoodsItem) => item2.id)
    }
  }
}