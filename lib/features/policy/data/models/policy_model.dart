import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/core/types/json_map.dart';
import 'package:insurance_mobile/features/policy/data/models/policy_json_keys.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';

part 'policy_model.freezed.dart';

@freezed
abstract class PolicyModel with _$PolicyModel {
  const PolicyModel._();

  const factory PolicyModel({
    required String id,
    required String policyNumber,
    required String holderName,
    required String type,
    required double coverageAmount,
    required DateTime startDate,
    required DateTime endDate,
    @Default(PolicyStatus.active) PolicyStatus status,
  }) = _PolicyModel;

  factory PolicyModel.fromJson(JsonMap json) {
    final id = json[PolicyJsonKeys.id];
    final startDateValue =
        json[PolicyJsonKeys.startDate] ?? json[PolicyJsonKeys.effectiveDate];
    final endDateValue =
        json[PolicyJsonKeys.endDate] ?? json[PolicyJsonKeys.expiryDate];
    final typeValue =
        json[PolicyJsonKeys.type] ?? json[PolicyJsonKeys.productName];
    final coverageAmount = json[PolicyJsonKeys.coverageAmount];

    if (id == null ||
        startDateValue == null ||
        endDateValue == null ||
        coverageAmount is! num) {
      throw const ParsingException(
        'Policy response is missing required fields.',
      );
    }

    return PolicyModel(
      id: id.toString(),
      policyNumber: (json[PolicyJsonKeys.policyNumber] as String?) ??
          'POL-${id.toString()}',
      holderName: (json[PolicyJsonKeys.holderName] as String?) ?? 'Policy Holder',
      type: (typeValue as String?) ?? PolicyType.vehicle.name,
      coverageAmount: coverageAmount.toDouble(),
      status: _policyStatusFromJson(json[PolicyJsonKeys.status]),
      startDate: DateTime.parse(startDateValue as String),
      endDate: DateTime.parse(endDateValue as String),
    );
  }

  JsonMap toJson() {
    return {
      PolicyJsonKeys.id: id,
      PolicyJsonKeys.policyNumber: policyNumber,
      PolicyJsonKeys.holderName: holderName,
      PolicyJsonKeys.type: type,
      PolicyJsonKeys.coverageAmount: coverageAmount,
      PolicyJsonKeys.status: status.name,
      PolicyJsonKeys.startDate: startDate.toIso8601String(),
      PolicyJsonKeys.endDate: endDate.toIso8601String(),
    };
  }
}

PolicyStatus _policyStatusFromJson(Object? value) {
  final normalized =
      (value as String? ?? 'active').trim().toLowerCase();

  return PolicyStatus.values.firstWhere(
    (s) => s.name == normalized,
    orElse: () => PolicyStatus.active,
  );
}
