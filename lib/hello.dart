main() {
  print("hello dart");

  var a = 10;
  var b = 8;
  print(a + b);
  print(a - b);
  print(a * b);
  print(a / b);
  print(a ~/ b);
  print(a % b);

  print(a.isEven);
  print(a.isFinite);
  print(a.isInfinite);
  print(a.isNaN);
  print(a.isOdd);
  print(a.isNegative);

  double m = 10;
  print(m);

  var str = r'我有一个梦想';
  print("hello: $str 价格 = $m");

  var list = new List();
  list.add(1);
  list.add(2);
  list.add(3);

  print(list);

  //不可变list
  var list2 = const [1, 2, 4, 5];
//  list2.add(6);
  print(list2);

  Map map = {"name": "张三", "age": 100};
  print(map);

  //不可变map
  Map map2 = const {"name": "张三", "age": 100};
  //不可新增，因为不可变
//  map2["address"] = "江苏南京";

  print(map2);

  Future.value("hello").then((value) {
    print(value);
  }, onError: (e) {
    print("onError: " + e);
  }).catchError((e) {
    print(e);
  });

  test();
}

test() async {
  print("start time : ${DateTime.now()}");
  var result = await Future.delayed(
      Duration(milliseconds: 2000), () => Future.value("success"));
  print("end time : ${DateTime.now()}");
  print(result);
}
