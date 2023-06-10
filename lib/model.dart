// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MedicationModel {
  String name;
  String description;
  String indication;
  String mechanism_of_action;
  String toxicity;
  String NOMDEMARQUE;
  String FORME;
  String DOSAGE;
  String COND;
  String LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT;
  String PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT;
  int id;
  MedicationModel({
    required this.name,
    required this.description,
    required this.indication,
    required this.mechanism_of_action,
    required this.toxicity,
    required this.NOMDEMARQUE,
    required this.FORME,
    required this.DOSAGE,
    required this.COND,
    required this.LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT,
    required this.PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT,
    required this.id,
  });

  MedicationModel copyWith({
    String? name,
    String? description,
    String? indication,
    String? mechanism_of_action,
    String? toxicity,
    String? NOMDEMARQUE,
    String? FORME,
    String? DOSAGE,
    String? COND,
    String? LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT,
    String? PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT,
    int? id,
  }) {
    return MedicationModel(
      name: name ?? this.name,
      description: description ?? this.description,
      indication: indication ?? this.indication,
      mechanism_of_action: mechanism_of_action ?? this.mechanism_of_action,
      toxicity: toxicity ?? this.toxicity,
      NOMDEMARQUE: NOMDEMARQUE ?? this.NOMDEMARQUE,
      FORME: FORME ?? this.FORME,
      DOSAGE: DOSAGE ?? this.DOSAGE,
      COND: COND ?? this.COND,
      LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT:
          LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT ??
              this.LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT,
      PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT:
          PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT ??
              this.PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'indication': indication,
      'mechanism_of_action': mechanism_of_action,
      'toxicity': toxicity,
      'NOMDEMARQUE': NOMDEMARQUE,
      'FORME': FORME,
      'DOSAGE': DOSAGE,
      'COND': COND,
      'LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT':
          LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT,
      'PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT':
          PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT,
      'id': id,
    };
  }

  factory MedicationModel.fromMap(Map<String, dynamic> map) {
    return MedicationModel(
      name: map['name'] ?.toString() ?? '//',
      description: map['description'] ?.toString() ?? '//',
      indication: map['indication']?.toString() ?? '//',
      mechanism_of_action: map['mechanism_of_action'] as String,
      toxicity: map['toxicity']?.toString() ?? '//',
      NOMDEMARQUE: map['NOMDEMARQUE'] ?.toString() ?? '//',
      FORME: map['FORME'] ?.toString() ?? '//',
      DOSAGE: map['DOSAGE'] ?.toString() ?? '//',
      COND: map['COND'] ?.toString() ?? '//',
      LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT:
          map['LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT'] ?.toString() ?? '//',
      PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT:
          map['PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT']
              ?.toString() ?? '//',
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicationModel.fromJson(String source) =>
      MedicationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MedicationModel(name: $name, description: $description, indication: $indication, mechanism_of_action: $mechanism_of_action, toxicity: $toxicity, NOMDEMARQUE: $NOMDEMARQUE, FORME: $FORME, DOSAGE: $DOSAGE, COND: $COND, LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT: $LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT, PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT: $PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT, id: $id)';
  }

  @override
  bool operator ==(covariant MedicationModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.indication == indication &&
        other.mechanism_of_action == mechanism_of_action &&
        other.toxicity == toxicity &&
        other.NOMDEMARQUE == NOMDEMARQUE &&
        other.FORME == FORME &&
        other.DOSAGE == DOSAGE &&
        other.COND == COND &&
        other.LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT ==
            LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT &&
        other.PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT ==
            PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        indication.hashCode ^
        mechanism_of_action.hashCode ^
        toxicity.hashCode ^
        NOMDEMARQUE.hashCode ^
        FORME.hashCode ^
        DOSAGE.hashCode ^
        COND.hashCode ^
        LABORATOIRESDETENTEURDELADECISIONDENREGISTREMENT.hashCode ^
        PAYSDULABORATOIREDETENTEURDELADECISIONDENREGISTREMENT.hashCode ^
        id.hashCode;
  }
}
