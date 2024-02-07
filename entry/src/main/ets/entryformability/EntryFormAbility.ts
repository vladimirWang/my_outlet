import formInfo from '@ohos.app.form.formInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import formProvider from '@ohos.app.form.formProvider';
import fs from '@ohos.file.fs'
import request from '@ohos.request';

export default class EntryFormAbility extends FormExtensionAbility {
  onAddForm(want) {
    let formData = {
      'text': 'Image: Bear',
      'imgName': 'imgBear',
      'loaded': true
    }
    // 将fd封装在formData中并返回至卡片页面
    return formBindingData.createFormBindingData(formData);
  }

  onFormEvent(formId, message) {
    let formInfo = formBindingData.createFormBindingData({
      'text': '刷新中...'
    })
    formProvider.updateForm(formId, formInfo)
    // 注意：FormExtensionAbility在触发生命周期回调时被拉起，仅能在后台存在5秒
    // 建议下载能快速下载完成的小文件，如在5秒内未下载完成，则此次网络图片无法刷新至卡片页面上
    let netFile = 'https://p1.itc.cn/images01/20220322/ce25fddac05a4ffba49227f9888dd875.jpeg'; // 需要在此处使用真实的网络图片下载链接
    let tempDir = this.context.getApplicationContext().tempDir;
    let tmpFile = tempDir + '/file' + Date.now();
    request.downloadFile(this.context, {
      url: netFile, filePath: tmpFile
    }).then((task) => {
      task.on('complete', function callback() {
        console.info('ArkTSCard download complete:' + tmpFile);
        try {
          const file = fs.openSync(tmpFile);
          let formData = {
            'text': 'Image: Https',
            'imgName': 'imgHttps',
            'formImages': {
              'imgHttps': file.fd
            },
            'loaded': true
          }
          let formInfo = formBindingData.createFormBindingData(formData)
          formProvider.updateForm(formId, formInfo).then((data) => {
            console.info('FormAbility updateForm success.' + JSON.stringify(data));
          }).catch((error) => {
            console.error('FormAbility updateForm failed: ' + JSON.stringify(error));
          })
        } catch (e) {
          console.error(`openSync failed: ${JSON.stringify(e)}`);
        }

      })
      task.on('fail', function callBack(err) {
        console.info('ArkTSCard download task failed. Cause:' + err);
        let formInfo = formBindingData.createFormBindingData({
          'text': '刷新失败'
        })
        formProvider.updateForm(formId, formInfo)
      });
    }).catch((err) => {
      console.error('Failed to request the download. Cause: ' + JSON.stringify(err));
    });
  }

  onAcquireFormState(want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }
};