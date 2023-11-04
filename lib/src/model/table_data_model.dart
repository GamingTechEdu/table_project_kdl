class Simcard {
  final String id;
  final String cliente;
  final String simcon;
  final String slotsimcon;
  final DateTime datainstalacao;
  final String numerochip;
  final DateTime dataaticacao;
  final String fornecedor;
  final String operadora;
  final String plano;
  final String apn;
  final String numerolinha;
  final String numeroip;
  final String obs;

  Simcard({
    required this.id,
    required this.cliente,
    required this.simcon,
    required this.slotsimcon,
    required this.datainstalacao,
    required this.numerochip,
    required this.dataaticacao,
    required this.fornecedor,
    required this.operadora,
    required this.plano,
    required this.apn,
    required this.numerolinha,
    required this.numeroip,
    required this.obs,
  });

  factory Simcard.fromJson(Map<String, dynamic> json) {
    return Simcard(
      id: json['id'],
      cliente: json['cliente'] ?? '',
      simcon: json['simcon'] ?? '',
      slotsimcon: json['slotsimcon'] ?? '',
      datainstalacao:
          DateTime.parse(json['datainstalacao'].split('-').reversed.join('-')),
      numerochip: json['numerochip'] ?? '',
      dataaticacao:
          DateTime.parse(json['dataaticacao'].split('-').reversed.join('-')),
      fornecedor: json['fornecedor'] ?? '',
      operadora: json['operadora'] ?? '',
      plano: json['plano'] ?? '',
      apn: json['apn'] ?? '',
      numerolinha: json['numerolinha'] ?? '',
      numeroip: json['numeroip'] ?? '',
      obs: json['obs'] ?? 'N/A',
    );
  }

  @override
  String toString() =>
      "id: $id, cliente: $cliente, simcon: $simcon, slotsimcon: $slotsimcon, datainstalacao: $datainstalacao, numerochip: $numerochip, dataaticacao: $dataaticacao, fornecedor: $fornecedor, operadora: $operadora, plano: $plano, apn: $apn, numerolinha: $numerolinha, numeroip: $numeroip, obs: $obs";


  Map<String, dynamic> get entries {
    return {
      'id': id,
      'slotsimcon': slotsimcon,
    };
  }
}
