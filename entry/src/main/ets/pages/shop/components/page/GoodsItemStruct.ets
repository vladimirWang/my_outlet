import promptAction from '@ohos.promptAction';
import {GoodsItem} from '../../types'

@Extend(Button) function smallBtn() {
  .width(26).height(26).backgroundColor('#eaeaea').fontColor('#333')
}

@Component
export default struct GoodsItemStruct {
  @ObjectLink @Watch('onUpdateGoods') goods: GoodsItem
  removeGoodsItem: () => void;
  businessId: string;
  updateSummary: () => void;
  @State handlePopup: boolean = false;

  onUpdateGoods() {
    this.updateSummary();
  }
  @Builder buildSum() {
    Row() {
      Button({ type: ButtonType.Normal }) {
        Text('-')
      }.smallBtn().smallBtn().onClick(() => {
        this.goods.count--;
      })

      Text(`${this.goods.count}`)
        .textAlign(TextAlign.Center)
        .height(26).width(50).fontSize(10)

      Button({ type: ButtonType.Normal }) {
        Text('+')
      }.smallBtn().onClick(() => {
        this.goods.count++;
      })
    }
  }
  build() {
    Row() {
      Checkbox({ group: this.businessId, name: this.goods.id })
        .selectedColor($r('app.color.dark_red'))
        .select(this.goods.selected)
        .margin({ right: 6 })
        .onChange(checked => {
          this.goods.selected = checked;
        })
      Image($rawfile(this.goods.icon)).width(120).margin({ right: 10 })

      Column() {
        Text(this.goods.name).width('50%').fontSize(16).fontWeight(FontWeight.Bold)
        Text(this.goods.specifications).backgroundColor('#f2f2f2')
          .padding(5).margin({ top: 5, bottom: 8 })
        Row() {
          Text(`¥ ${this.goods.price}`)
            .constraintSize({ minWidth: 80 })
            .fontColor($r('app.color.dark_red'))
          // 数量修改
          // this.buildSum()
          Counter(){
            Text(`${this.goods.count}`)
          }.onInc(() => {
            this.goods.count++
          }).onDec(() => {
            if (this.goods.count=== 1) {
              this.handlePopup = true
            } else {
              this.goods.count--
            }
          }).bindPopup(this.handlePopup, {
            message: '确认要删除吗?',
            // mask: {color:'0x33000000'},
            primaryButton: {
              value: '确认',
              action: () => {
                this.handlePopup = false;
                this.removeGoodsItem()
              }
            },
            secondaryButton: {
              value: '取消',
              action: () => {
                this.handlePopup = false
              }
            }
          })
        }.width('50%')
      }.alignItems(HorizontalAlign.Start)
    }
    .padding(8)
    .width('95%')
    .justifyContent(FlexAlign.SpaceBetween)
    .border({ width: { bottom: 1 }, color: Color.Gray, style: BorderStyle.Solid })
  }
}