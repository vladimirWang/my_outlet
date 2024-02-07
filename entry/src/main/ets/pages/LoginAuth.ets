import dataPreferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';
import { CommonConstants as Const } from '../common/constants/CommonConstants';
import prompt from '@ohos.promptAction';
import router from '@ohos.router';
import Notification from '@ohos.notificationManager';
import wantAgent from '@ohos.app.ability.wantAgent';
import Logger from '../common/utils/Logger';
import ResponseResult from '../common/bean/ResponseResult';
import { httpRequestGet, httpRequestPost } from '../common/utils/HttpUtil';

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

//wantAgent回调
function wantAgentCallback(err) {
  if (err) {
    console.info("publish failed " + JSON.stringify(err));
  } else {
    console.info("publish success");
  }
}

//publish回调
function publishCallback(err) {
  if (err) {
    console.info("publish failed " + JSON.stringify(err));
  } else {
    console.info("publish success");
  }
}

// 生成6位随机数
function generateRandomNumber() {
  let randomNumber = '';
  for (let i = 0; i < 6; i++) {
    randomNumber += Math.floor(Math.random() * 10);
  }
  return randomNumber + '';
}

@Entry
@Component
struct LoginAuth {
  @State account: string = router.getParams()['account'];
  @State isLogin: boolean = router.getParams()['isLogin'];
  @State userName: string = '';
  @State password: string = '';
  @State captcha: string = '';
  @State isCheck: boolean = false;
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;
  private context = getContext(this) as common.UIAbilityContext;
  private preferences: dataPreferences.Preferences = null;
  // private randomNum: string = Math.floor(Math.random() * 1000000) + "";
  private randomNum: string = generateRandomNumber();

  aboutToAppear() {

  }

  onPageShow() {
    // 页面加载 2 秒后，弹出通知栏，并显示验证码
    setTimeout(() => {
      this.isShowProgress = false;
      this.timeOutId = -1;
      let wantAgentInfo = {
        wants: [
          {
            action: 'event_name', // 设置事件名
            parameters: {},
          }
        ],
        operationType: wantAgent.OperationType.SEND_COMMON_EVENT,
        requestCode: 100,
        wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG],
      }
      let wantAgentObj = null;
      wantAgent.getWantAgent(wantAgentInfo)
        .then((data) => {
          wantAgentObj = data;
        })
        .catch((err) => {
          console.error(`get wantAgent failed because ${JSON.stringify(err)}`);
        })
      //通知Request对象
      let notificationRequest = {
        id: 1,
        content: {
          contentType: Notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "10698888888",
            text: `【中国银联】验证码${this.randomNum}，有效期1分钟。此验证码仅可用户登录云闪付APP`,
            // additionalText: `【中国银联】验证码${this.randomNum}，有附加`
          }
          // deliveryTime: 2000,

        }
        ,slotType: Notification.SlotType.SOCIAL_COMMUNICATION
        ,isStopwatch: true
        ,showDeliveryTime: true
        /*,actionButtons: [
          {title: '回复', wantAgent: null},
          {title: '标记已读', wantAgent: null},
          {title: '复制验证码', wantAgent: null}
        ]*/
      };
      Notification.publish(notificationRequest, publishCallback);
    }, Const.LOGIN_DELAY_TIME);
  }

  login(): void {
    if (this.captcha !== this.randomNum){
      prompt.showToast({
        message: '输入的验证码有误，请重新输入'
      })
    } else {
      this.isShowProgress = true;
      // 登录验证成功后将用户信息保存到首选项中
      try {
        dataPreferences.getPreferences(this.context, Const.H_STORE, (err, preferences) => {
          if (!err) {
            this.preferences = preferences;

            this.preferences.put(Const.USER_ACCOUNT_KEY, this.account, (err) => {
              if (err) {
                return;
              }
              this.preferences.flush()
            })

          }
        })
      } catch (err) {
        Logger.error(`Failed to put preferences. Code:${err.code},message:${err.message}`);
      }
      // 当为注册时，将账户保存到mysql库
      if (!this.isLogin) {
        let url = `${Const.UNIONPAY_SERVER}/${Const.GET_ADD_USER}`;
        httpRequestPost(url,this.account,this.userName,this.password).then((data: ResponseResult) => {
          Logger.info('Login','httpRequestPost success.');
        }).catch((err: Error) => {
          Logger.error('Login','httpRequestPost failed. Cause:' + err);
        });
      }

      // 跳转到pages/LoginAuth登录验证页面
      this.jumpHomePage();
    }
  }

  jumpHomePage() {
    this.timeOutId = setTimeout(() => {
      this.isShowProgress = false;
      this.timeOutId = -1;
      router.replaceUrl({ url: 'pages/Index',params: {account: this.account} });
    }, Const.LOGIN_DELAY_TIME);
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.left2'))
          .width(25)
          .height(25)
          .onClick(() => {
            router.back();
          })
        // .margin({ left: 10 })
        // 为登录时显示新用户注册按钮
        if (this.isLogin) {
          Button('新用户注册', { type: ButtonType.Capsule, stateEffect: true })
            .backgroundColor(0xffffff)
            .width(100)
            .fontSize(12)
            .fontColor(Color.Red)
            .borderColor(Color.Red)
            .borderWidth(1)
            .onClick(() => {
              router.pushUrl({ url: 'pages/Register',params: {account: this.account} });
            })
        }

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      Image($r('app.media.cloudPay_logo'))
        .width(78)
        .height(78)
        .margin({ top: 100, bottom: 30 })

      Text(`+86 ${this.account}`)
        .textAlign(TextAlign.Center)
        .fontSize(21)
        .padding(10)
        .fontWeight(FontWeight.Bold)

      Row() {
        Text("验证码 ")
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)
          .fontSize(18)

        TextInput({ placeholder: '请输入短信验证码' })
          .maxLength(Const.INPUT_SMS_LENGTH)
          .type(InputType.Number)
          .inputStyle()
          .onChange((value: string) => {
            if (value.length === 6) {
              this.captcha = value;
              this.isCheck = true;
            } else {
              this.isCheck = false;
            }
          })
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .margin({ top: 50 })

      Line().lineStyle()

      Button(this.isLogin ? "登录" : "下一步", { type: ButtonType.Normal, stateEffect: true })
        .backgroundColor(Color.Red)
        .width("98%")
        .fontSize(18)
        .margin({ top: 30})
        .enabled(this.isCheck)
        .onClick(() => {
          this.login();
        })

      Text("换种方式登录")
        .fontSize(18)
        .fontColor("#ff0365bc")
        .textAlign(TextAlign.Center)
        .margin({
          top: '20vp',
          // left: '35vp'
        })

      // 显示加载图
      if (this.isShowProgress) {
        LoadingProgress()
          .color($r('app.color.loading_color'))
          .width($r('app.float.login_progress_size'))
          .height($r('app.float.login_progress_size'))
          .margin({ top: $r('app.float.login_progress_margin_top') })
      }

      Text("遇到问题？")
        .fontSize(18)
        .fontColor("#ff0365bc")
        .textAlign(TextAlign.Center)
        .margin({
          top: '200vp',
          // left: '35vp'
        })
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