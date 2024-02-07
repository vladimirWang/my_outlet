
@Component
export struct SelectComponent {
  build() {
    Column() {
      Select([{ value: '北京'},
        { value: '上海'},
        { value: '杭州'},
        { value: '苏州'}])
        .selected(1)
        .value('上海')
        .font({ size: 14, weight: 1000 })
        .align(Alignment.Center)
        .fontColor('#fff')
        .selectedOptionFont({ size: 14, weight: 400 })
        .optionFont({ size: 14, weight: 400 })
        .backgroundColor('#ED171F')
        .onSelect((index: number) => {
          console.info('Select:' + index)
        })
    }.width(60).margin({
      left:-10
    }).alignItems(HorizontalAlign.Start)
  }
}
