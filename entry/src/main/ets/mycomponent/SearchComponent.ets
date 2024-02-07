
@Component
export struct SearchComponent {
@State changeValue: string = ''
@State submitValue: string = ''
controller: SearchController = new SearchController()

build() {
  Column() {
    Search({ value: this.changeValue, placeholder: '输入您要搜索的内容...', controller: this.controller })
      .searchButton('搜索')
      .backgroundColor('#F5F5F5')
      .height(30)
      .width('100%')
      .placeholderColor(Color.Grey)
      .placeholderFont({ size: 14, weight: 400 })
      .onSubmit((value: string) => {
        this.submitValue = value
      })
      .onChange((value: string) => {
        this.changeValue = value
      })
  }.width('100%')
}
}