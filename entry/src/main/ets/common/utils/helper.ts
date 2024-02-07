export function cardStars(cardNo): string {
  const start = cardNo.substr(0, 4)
  const end = cardNo.substr(-4)
  return `${start}****${end}`;
  // console.info("---card: ", cardNo, cardNo.substr(0, 4), cardNo.substr(-4))
  // return '123'
}

export function sleep(ms = 2000): Promise<void> {
  return new Promise(r => {
    setTimeout(r, ms)
  })
}
