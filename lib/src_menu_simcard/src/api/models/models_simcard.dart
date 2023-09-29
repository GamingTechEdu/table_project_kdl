class Simcard {
  String? idCostumer;
  String? idSimcard;
  int? idSimcon;
  int? idLinha;
  dynamic idIP;
  String idSupplier;
  String? idSlot;
  String observations;
  String? supplierType;
  String? idPlan;
  String? idDateActi;
  String? idDateinsta;

  Simcard({
    this.idCostumer,
    this.idSimcard,
    this.idSimcon,
    this.idLinha,
    this.idIP,
    this.idSupplier = "",
    this.idSlot,
    this.observations = "",
    this.supplierType = "",
    this.idPlan,
    this.idDateActi,
    this.idDateinsta,
  });

  Map<String, dynamic> toJson() {
    return {
      'idCostumer': idCostumer,
      'idSimcard': idSimcard,
      'idSimcon': idSimcon,
      'idLinha': idLinha,
      'idIP': idIP,
      'idSupplier': idSupplier,
      'idSlot': idSlot,
      'supplierType': supplierType,
      'idPlan': idPlan,
      'idDateActi': idDateActi,
      'idDateinsta': idDateinsta,
      'observations': observations,
    };
  }

  @override
  String toString() {
    return 'Instance of TaskModel(idCostumer:$idCostumer)';
  }
}
