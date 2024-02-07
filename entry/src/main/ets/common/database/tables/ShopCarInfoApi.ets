// import dataRdb from '@ohos.data.relationalStore';
// import { CommonConstants as Const } from '../../constants/CommonConstants';
import RdbUtils from '../Rdb/RdbUtils';
// import Logger from '../../utils/Logger';

// const mock = [
//   {
//     id: 1,
//     title: '优惠助手',
//     desc: '点击即领还款券，最高得620元，信用卡还款0手续费',
//     type: 0,
//   }
// ];

interface IPaginationData {
  list: any[];
  count: number;
}

class TaskInfoApi {

  insert(params) {
    return RdbUtils.insert('shopCarInfo', params)
  }

  update() {
  }

  queryAll(): Promise<IPaginationData> {
    return RdbUtils.queryAll("shopCarInfo").then(resultSet => {
      const count = resultSet.rowCount;
      resultSet.goToFirstRow();
      const result = []
      for (let i = 0; i < count; i++) {
        let tmp: any = {};
        tmp.id = resultSet.getString(resultSet.getColumnIndex('id'));
        tmp.icon = resultSet.getString(resultSet.getColumnIndex('icon'));
        tmp.name = resultSet.getString(resultSet.getColumnIndex('name'));
        tmp.price = resultSet.getDouble(resultSet.getColumnIndex('price'));
        tmp.sold = resultSet.getString(resultSet.getColumnIndex('sold'));
        tmp.specifications = resultSet.getString(resultSet.getColumnIndex('specifications'));
        tmp.address = resultSet.getString(resultSet.getColumnIndex('address'));
        tmp.business = resultSet.getString(resultSet.getColumnIndex('business'));
        tmp.businessId = resultSet.getString(resultSet.getColumnIndex('businessId'));
        tmp.count = resultSet.getDouble(resultSet.getColumnIndex('count'));
        result[i] = tmp;
        resultSet.goToNextRow();
      }
      return { list: result, count }
    })
  }
}

export default new TaskInfoApi();