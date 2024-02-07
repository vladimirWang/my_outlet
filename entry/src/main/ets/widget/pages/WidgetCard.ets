let storage = new LocalStorage();

@Entry(storage)
@Component
struct WidgetCard {
  @LocalStorageProp('text') text: string = '加载中...';
  @LocalStorageProp('loaded') loaded: boolean = false;
  @LocalStorageProp('imgName') imgName: string = 'name';
  onPageShow() {
    console.log('on page show card')
  }

  build() {
    Column() {
      Text(this.text)
        .fontSize('12vp')
        .textAlign(TextAlign.Center)
        .width('100%')
        .height('15%')

      Row() {
        if (this.loaded) {
          Image('memory://' + this.imgName)
            .width('50%')
            .height('50%')
            .margin('5%')
        } else {
          Image('common/start.PNG')
            .width('50%')
            .height('50%')
            .margin('5%')
        }
      }.alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Button('刷新')
        .height('15%')
        .onClick(() => {
          postCardAction(this, {
            'action': 'message',
            'params': {
              'info': 'refreshImage'
            }
          });
        })
    }
    .width('100%').height('100%')
    .alignItems(HorizontalAlign.Center)
    .padding('5%')
  }
}