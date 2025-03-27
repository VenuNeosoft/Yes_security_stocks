class StockModel {
  final String symbol;
  final String exchange;
  final String type;
  final String holdings;
  final String open;
  final String high;
  final String low;
  final String ltp;
  final String ptsC;
  final String chgp;
  final String trdVol;
  final String wkhi;
  final String wklo;

  StockModel({
    required this.symbol,
    required this.exchange,
    required this.type,
    required this.holdings,
    required this.open,
    required this.high,
    required this.low,
    required this.ltp,
    required this.ptsC,
    required this.chgp,
    required this.trdVol,
    required this.wkhi,
    required this.wklo,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'],
      exchange: json['exchange'],
      type: json['type'],
      holdings: json['holdings'],
      open: json['open'],
      high: json['high'],
      low: json['low'],
      ltp: json['ltp'],
      ptsC: json['ptsC'],
      chgp: json['chgp'],
      trdVol: json['trdVol'],
      wkhi: json['wkhi'],
      wklo: json['wklo'],
    );
  }
  factory StockModel.empty() {
    return StockModel(
      symbol: '',
      exchange: '',
      type: '',
      holdings: '',
      open: '',
      high: '',
      low: '',
      ltp: '',
      ptsC: '',
      chgp: '',
      trdVol: '',
      wkhi: '',
      wklo: '',
    );
  }
}
