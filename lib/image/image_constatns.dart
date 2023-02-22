class ImageConstants {
  static ImageConstants? _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  ImageConstants._init();

  String get user => toPng('user');

  String get error => toPng('error');

  String get getirLogo => toPng('getirlogo');

  String get getirBanner => toPng('getir_banner');

  String get yemeksepetiLogo => toPng('yslogo');

  String get printer => toPng('printer');

  String get ideaslogo => toPng('ideaslogo');

  String get connection => toPng('connection');

  String get paket => toPng('paket');

  String get fuudy => toPng('fuudy');

  String toPng(String name) => 'assets/images/$name.png';
}
