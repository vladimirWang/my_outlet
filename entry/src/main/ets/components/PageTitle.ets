import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Preview
@Component
export default struct PageTitle {
  @Prop title: string;
  // @Prop backGroundColor: string  = '#fff'   组件内无法本地初始化,版本缺陷,下个版本修复
  build() {
    Column() {
      Row() {
        //左侧图标区域
        Row() {
          Image($r('app.media.left'))
            .width(24)
            .height(24)
            .onClick(() => {
              // promptAction.showToast({message: 'fff'})
              router.back()
            })
        }.position({x: 10, y: 0})
        // .width(50)
        // .margin({ left: 15 })
        //title文字区域
        Text(this.title)
          .fontWeight(FontWeight.Bolder)
          .fontSize(18)
          .textAlign(TextAlign.Center)
            // .layoutWeight(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
        // .width("100%")
        // .backgroundColor('red')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ top: 15, bottom: 15 })
      Divider().strokeWidth(3)
    }.width('100%')
  }
}