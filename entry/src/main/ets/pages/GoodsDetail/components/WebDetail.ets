import webview from '@ohos.web.webview';
@Component
export default struct WebDetail {
  webController: webview.WebviewController = new webview.WebviewController();
  build() {
    Web({ src: $rawfile('index.html'), controller: this.webController })
      .zoomAccess(false)
      .width("90%")
      .aspectRatio(1)
      .margin("3%")
  }
}