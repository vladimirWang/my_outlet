
export  class OrderSureData {
  name: string;
  phone: string|number;
  address: string;
  constructor(name: string, phone: string |number,address: string ) {
    this.name = name;
    this.phone = phone;
    this.address = address;
  }
}

export  class CommodityData {
  shopName: string;
  imgSrc: string;
  text: string;
  count:string;
  price:string|number;
  constructor(shopName: string,
              imgSrc: string,
              text: string,
              count: string,
              price: string |number, ) {
    this.shopName = shopName;
    this.imgSrc = imgSrc;
    this.text = text;
    this.count = count;
    this.price = price;
  }
}