import ColumnInfo from '../viewmodel/ColumnInfo';

export const columnShopCarInfoList: Array<ColumnInfo> = [
  new ColumnInfo('id', 'text', -1, true, true, false),
  new ColumnInfo('icon', 'text', -1, true, false, false),
  new ColumnInfo('name', 'text', -1, true, false, false),
  new ColumnInfo('price', 'integer', -1, true, false, false),
  new ColumnInfo('sold', 'text', -1, true, false, false),
  new ColumnInfo('specifications', 'text', -1, true, false, false),
  new ColumnInfo('address', 'text', -1, true, false, false),
  new ColumnInfo('business', 'text', -1, true, false, false),
  new ColumnInfo('businessId', 'text', -1, true, false, false),
  new ColumnInfo('count', 'integer', -1, true, false, false)
]
