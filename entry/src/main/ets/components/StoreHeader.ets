@Component
export default struct StoreHeader {
  storeName: string;
  build() {
    Row() {
      Image($r('app.media.ic_shop')).width(24).margin({right: 12})
      Text(this.storeName).fontSize(16)
    }.width('100%')
    .padding({top: 5, bottom: 5})
  }
}