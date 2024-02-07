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

  build() {
    Column() {
      Row() {
        Flex({ wrap: FlexWrap.Wrap }) {
          // 店铺名称
          Row() {
            CheckboxGroup({ group: this.item.businessId })
              .selectedColor($r('app.color.dark_red'))
            // .selectAll(this.allSelected)
            StoreHeader({storeName: this.item.business})
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
            this.updateSummary();
          }
        })
      }, item2 => item2.id)
    }
  }
}