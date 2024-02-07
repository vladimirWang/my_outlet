import { CommonConstants as Const } from '../common/constants/CommonConstants';
import router from '@ohos.router';
import common from '@ohos.app.ability.common';
import dataPreferences from '@ohos.data.preferences';
import prompt from '@ohos.promptAction';
import Logger from '../common/utils/Logger';
import { httpRequestGet } from '../common/utils/HttpUtil';
import ResponseResult from '../common/bean/ResponseResult';
import promptAction from '@ohos.promptAction';

@Extend(TextInput) function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor($r('app.color.background'))
  .width('90%')
  .padding({ left: 60 })
  // .margin({ top: $r('app.float.input_margin_top') })
}

@Extend(Line) function lineStyle() {
  .width(Const.FULL_PARENT)
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

@Extend(Text) function blueTextStyle() {
  .fontColor($r('app.color.login_blue_text_color'))
  .fontSize($r('app.float.small_text_size'))
  .fontWeight(FontWeight.Medium)
}

const H_STORE: string = 'unionPayStore';
const PHONE_NUMBER_REGEX = /^1[3456789]\d{9}$/;

@Entry
@Component
struct Register {
  @State account: string = '';
  @State password: string = '';
  @State isCheck: boolean = false;
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;
  @State agreeFlag: boolean = false;
  private context = getContext(this) as common.UIAbilityContext;
  private preferences: dataPreferences.Preferences = null;

  async register(): Promise<void> {
    // this.isShowProgress = true;
    const params = {
      "username": "fiona",
      "password": "123456"
    }
    // httpRequestPost(url, params).then((data: ResponseResult) => {
    //   console.log('typeof: ', typeof data.count)
    //   promptAction.showToast({message: typeof data})
    //   // if (data.count !== 0) {
    //   //   prompt.showToast({
    //   //     message: '用户已存在，请更换换号注册或移步登录界面登录'
    //   //   })
    //   //   this.isShowProgress = false;
    //   //   return ;
    //   // } else {
    //   //   if (this.timeOutId === -1) {
    //   //     // 校验通过后将注册账号保存到首选项中
    //   //     let preferences = dataPreferences.getPreferences(this.context, H_STORE);
    //   //     preferences.then((res) => {
    //   //       res.put(Const.USER_ACCOUNT_KEY, this.account).then(() => {
    //   //         res.flush();
    //   //         Logger.info('Login','account is put success');
    //   //       }).catch((err: Error) => {
    //   //         Logger.error('Login','account put failed. Cause:' + err);
    //   //       });
    //   //     })
    //   //
    //   //     // 跳转到pages/LoginAuth登录验证页面
    //   //     this.jumpLoginAuthPage();
    //   //   }
    //   // }
    // }).catch((err: Error) => {
    //   Logger.error('Login','httpRequestGet failed. Cause:' + err);
    // });

  }

  jumpLoginAuthPage() {
    this.timeOutId = setTimeout(() => {
      this.isShowProgress = false;
      this.timeOutId = -1;
      router.pushUrl({ url: 'pages/LoginAuth',params: {account: this.account, isLogin: false} });
    }, Const.LOGIN_DELAY_TIME);
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.back'))
          .width(25)
          .height(25)
          .onClick(() => {
            router.back();
          })
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')

      Row() {
        Text('手机号注册')
          .fontSize(35)
          .fontWeight(500)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({top: 50, bottom: 100})



      Row() {
        Text("国家/地区")
          .fontColor(Color.Gray)
        Text("中国大陆")
          .margin({ left: 20})
        Image($r('app.media.arraw_right_black'))
          .width(30)
          .height(30)
          .margin({ left: 150})
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .margin({bottom: 20})

      Line().lineStyle()
      Button('test').onClick(() => {
        const url = "http://130.252.53.107:9588/news/getNewsType"
        httpRequestGet(url).then(res => {
          console.log((res as any).data, typeof res, '---11ressss00000')
          promptAction.showToast({message: res.msg + ''})
        })
      })
      Row() {
        Text("+86 ")
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)
          .fontSize(18)

        TextInput({ placeholder: '请输入手机号', text: this.account })
          .maxLength(Const.INPUT_ACCOUNT_LENGTH)
          .type(InputType.Number)
          .inputStyle()
            // 正则表达式，匹配表达式的输入允许显示，不匹配的输入将被过滤。目前仅支持单个字符匹配，不支持字符串匹配。
            /*.inputFilter('[1][3,4,5,7,8][0-9]{9}', (e) => {
              console.log(JSON.stringify(e))
            })*/
          .onChange((value: string) => {
            if (value.length === 11) {
              if (!PHONE_NUMBER_REGEX.test(value)) {
                prompt.showToast({
                  message: '请输入正确的手机号'
                })
                return ;
              }
              this.account = value;
              this.isCheck = true;
            } else {
              this.isCheck = false;
            }

          })
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .margin({ top: 30 })

      Line().lineStyle()

      Row() {
        Checkbox({name: 'checkbox1',  group: 'checkboxGroup'})
          .select(this.agreeFlag)
            // .margin(10)
          .selectedColor(Color.Red)
          .onChange((value: boolean) => {
            this.agreeFlag = value;
            console.info('Checkbox1 change is'+ value)
          })
        Text("我已阅读并同意")
          .fontColor(Color.Grey)
          .fontSize(15)
          .margin({
            left: '1vp'
          })
        Text("《隐私保护协议》")
          .fontSize(15)
          .fontColor(Color.Blue)
        Text("及")
          .fontSize(15)
      }
      .width('100%')
      .margin({ top: 20})

      Row() {
        Text("《银联用户服务协议》")
          .fontSize(15)
          .fontColor(Color.Blue)
      }
      .width('100%')
      .margin({ left: 20})

      Button("注册", { type: ButtonType.Normal, stateEffect: true })
        .backgroundColor($r('app.color.dark_red'))
        .width("98%")
        .fontSize(18)
        .margin({ top: 30})
        // .enabled(this.isCheck && this.agreeFlag)
        .onClick(() => {
          this.register();
        })

      if (this.isShowProgress) {
        LoadingProgress()
          .color($r('app.color.loading_color'))
          .width($r('app.float.login_progress_size'))
          .height($r('app.float.login_progress_size'))
          .margin({ top: $r('app.float.login_progress_margin_top') })
      }

    }
    .backgroundColor($r('app.color.background'))
    .width('100%')
    .height('100%')
    .padding({
      left: 12,
      right: 12,
      top: 12,
      bottom: 12
    })
  }
}