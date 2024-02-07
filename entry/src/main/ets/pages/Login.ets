import { CommonConstants as Const } from '../common/constants/CommonConstants';
import router from '@ohos.router';
import common from '@ohos.app.ability.common';
import dataPreferences from '@ohos.data.preferences';
import prompt from '@ohos.promptAction';
import Logger from '../common/utils/Logger';
// import { httpRequestGet } from '../common/utils/HttpUtil';
import ResponseResult from '../common/bean/ResponseResult';
import Curves from '@ohos.curves'
@Extend(TextInput) function inputStyle() {
  .placeholderColor("请输入手机号")
  .height(45)
  .fontSize(24).textAlign(TextAlign.Center)
  .backgroundColor($r('app.color.background'))
  // .width('90%')
  // .padding({ left: 60 })
  .margin({ top: $r('app.float.input_margin_top') })
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

function checkTelephone(telephone) {
  var reg=/^[1][3,4,5,7,8][0-9]{9}$/;
  if (!reg.test(telephone)) {
    return false;
  } else {
    return true;
  }
}

const PHONE_NUMBER_REGEX = /^1\d{10}$/;

@Entry
@Component
struct Login {
  @State widthSize: number = 200
  @State heightSize: number = 200
  @State @Watch('validatePhoneNumber') account: string = '';
  @State password: string = '';
  @State isValid: boolean = false;
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;
  private context = getContext(this) as common.UIAbilityContext;
  private preferences: dataPreferences.Preferences = null;

  // 电话号码输入时校验，是否符合规则
  validatePhoneNumber(): void {
    const raw = this.account.split(' ').join('')
    const bool = PHONE_NUMBER_REGEX.test(raw)
    this.isValid = bool;
  }

  aboutToAppear() {
    try {
      dataPreferences.getPreferences(this.context, Const.H_STORE, (err, preferences) => {
        if (!err) {
          this.preferences = preferences;

          this.preferences.get(Const.USER_ACCOUNT_KEY, '', (err, val) => {
            if (err) {
              // AlertDialog.show({ message: "读取失败：" });
              return;
            }
            this.account = val + "";
            this.loginDefault();
          });
        }
      })
    } catch (err) {
      console.error(`Failed to get preferences. Code:${err.code},message:${err.message}`);
    }
  }

  loginDefault(): void {
    if (this.account !== '') {
      router.replaceUrl({ url: 'pages/Index',params: {account: this.account} });
    }
  }

  next(): void {
    this.isShowProgress = true;
    // let url = `${Const.UNIONPAY_SERVER}/${Const.GET_CHECK_USER}/?account=${this.account}`;
    const url = '/api/auth/login'
  }

  jumpLoginAuthPage() {
    this.timeOutId = setTimeout(() => {
      this.isShowProgress = false;
      this.timeOutId = -1;
      router.pushUrl({ url: 'pages/LoginAuth',params: {account: this.account, isLogin: true} });
    }, Const.LOGIN_DELAY_TIME);
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.close'))
          .width(25)
          .height(25)
          .onClick(() => {
            this.context.terminateSelf();
          })
        Button('新用户注册', { type: ButtonType.Capsule, stateEffect: true })
          .backgroundColor($r('app.color.background'))
          .width(100)
          .fontSize(12)
          .fontColor(Color.Red)
          .borderColor(Color.Red)
          .borderWidth(1)
          .onClick(() => {
            router.pushUrl({ url: 'pages/Register',params: {account: this.account} });
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      Image($r('app.media.cloudPay_logo'))
        .width(78)
        .height(78)
        .margin({ top: 100, bottom: 60 })

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

      TextInput({ placeholder: '请输入手机号', text: this.account })
        .maxLength(13)
        .type(InputType.PhoneNumber)
        .inputStyle()
        .inputFilter('[0-9]')
        .onChange((value: string) => {
          if (value.length<3) {
            this.account = value;
          } else if (value.length === 3) {
            this.account = value+' '
          } else if (value.length < 8) {
            this.account = value
          } else if (value.length === 8) {
            this.account = value+' '
          } else {
            this.account = value;
          }
        })

      Line().lineStyle()

      Button("下一步", { type: ButtonType.Normal, stateEffect: true })
        .backgroundColor($r('app.color.dark_red'))
        .width("98%")
        .fontSize(18)
        .margin({ top: 30})
        .enabled(this.isValid)
        .onClick(() => {
          this.next();
        })

      Text("邮箱/用户名登录")
        .fontSize(18)
        .fontColor("#ff0365bc")
        .textAlign(TextAlign.Center)
        .margin({
          top: '20vp',
        })
      if (this.isShowProgress) {
        LoadingProgress()
          .color($r('app.color.loading_color'))
          .width($r('app.float.login_progress_size'))
          .height($r('app.float.login_progress_size'))
          .margin({ top: $r('app.float.login_progress_margin_top') })
      }
      // Text()
      //   .margin({top:100})
      //   .width(this.widthSize)
      //   .height(this.heightSize)
      //   .backgroundColor(Color.Red)
      //   .onClick(()=> {
      //     let curve = Curves.cubicBezierCurve(0.25, 0.1, 0.25, 1.0);
      //     this.widthSize = curve.interpolate(0.5) * this.widthSize;
      //     this.heightSize = curve.interpolate(0.5) * this.heightSize;
      //   })
      //   .animation({ duration: 2000 , curve: Curves.stepsCurve(9, true) })
      // Row() {
      //   Image($r('app.media.github')).width(30).margin({right: 20})
      //   Image($r('app.media.wechat')).width(30)
      // }.position({y: '0%', x: 0}).width('100%').height(200).backgroundColor('red')
    }
    .backgroundColor($r('app.color.background'))
    .width('100%')
    .height('100%')
    .padding(12)
  }
}