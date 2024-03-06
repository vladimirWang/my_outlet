@Observed
class GoodsItem {
  public businessId: string;
  public business: string;
  public id: string;
  public name: string;
  public price: number;
  public sold: string;
  public specifications: string;
  public address: string;
  public count: number;
  public icon?: string;
  public selected: boolean;
  constructor(businessId, business, id, name, price, sold, specifications, address, count, icon, selected = false) {
    this.businessId = businessId;
    this.business = business;
    this.id = id;
    this.name = name;
    this.price = price;
    this.sold = sold;
    this.specifications = specifications;
    this.address = address;
    this.count = count;
    this.icon = icon;
    this.selected = selected;
  }
}

@Observed
class Shop {
  public isChanged: boolean;
  public business: string;
  public businessId: string;
  children?: GoodsItem[]

  constructor(business, businessId, goods =[], isChanged) {
    this.business = business;
    this.businessId = businessId;
    this.children = goods;
    this.isChanged = isChanged
  }
}

export {
  Shop,
  GoodsItem
}