// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'policy_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PolicyModel {

 String get id; String get policyNumber; String get holderName; String get type; double get coverageAmount; DateTime get startDate; DateTime get endDate; PolicyStatus get status;
/// Create a copy of PolicyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolicyModelCopyWith<PolicyModel> get copyWith => _$PolicyModelCopyWithImpl<PolicyModel>(this as PolicyModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolicyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.policyNumber, policyNumber) || other.policyNumber == policyNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.type, type) || other.type == type)&&(identical(other.coverageAmount, coverageAmount) || other.coverageAmount == coverageAmount)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,policyNumber,holderName,type,coverageAmount,startDate,endDate,status);

@override
String toString() {
  return 'PolicyModel(id: $id, policyNumber: $policyNumber, holderName: $holderName, type: $type, coverageAmount: $coverageAmount, startDate: $startDate, endDate: $endDate, status: $status)';
}


}

/// @nodoc
abstract mixin class $PolicyModelCopyWith<$Res>  {
  factory $PolicyModelCopyWith(PolicyModel value, $Res Function(PolicyModel) _then) = _$PolicyModelCopyWithImpl;
@useResult
$Res call({
 String id, String policyNumber, String holderName, String type, double coverageAmount, DateTime startDate, DateTime endDate, PolicyStatus status
});




}
/// @nodoc
class _$PolicyModelCopyWithImpl<$Res>
    implements $PolicyModelCopyWith<$Res> {
  _$PolicyModelCopyWithImpl(this._self, this._then);

  final PolicyModel _self;
  final $Res Function(PolicyModel) _then;

/// Create a copy of PolicyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? policyNumber = null,Object? holderName = null,Object? type = null,Object? coverageAmount = null,Object? startDate = null,Object? endDate = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,policyNumber: null == policyNumber ? _self.policyNumber : policyNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,coverageAmount: null == coverageAmount ? _self.coverageAmount : coverageAmount // ignore: cast_nullable_to_non_nullable
as double,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PolicyStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [PolicyModel].
extension PolicyModelPatterns on PolicyModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PolicyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PolicyModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PolicyModel value)  $default,){
final _that = this;
switch (_that) {
case _PolicyModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PolicyModel value)?  $default,){
final _that = this;
switch (_that) {
case _PolicyModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String policyNumber,  String holderName,  String type,  double coverageAmount,  DateTime startDate,  DateTime endDate,  PolicyStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PolicyModel() when $default != null:
return $default(_that.id,_that.policyNumber,_that.holderName,_that.type,_that.coverageAmount,_that.startDate,_that.endDate,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String policyNumber,  String holderName,  String type,  double coverageAmount,  DateTime startDate,  DateTime endDate,  PolicyStatus status)  $default,) {final _that = this;
switch (_that) {
case _PolicyModel():
return $default(_that.id,_that.policyNumber,_that.holderName,_that.type,_that.coverageAmount,_that.startDate,_that.endDate,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String policyNumber,  String holderName,  String type,  double coverageAmount,  DateTime startDate,  DateTime endDate,  PolicyStatus status)?  $default,) {final _that = this;
switch (_that) {
case _PolicyModel() when $default != null:
return $default(_that.id,_that.policyNumber,_that.holderName,_that.type,_that.coverageAmount,_that.startDate,_that.endDate,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _PolicyModel extends PolicyModel {
  const _PolicyModel({required this.id, required this.policyNumber, required this.holderName, required this.type, required this.coverageAmount, required this.startDate, required this.endDate, this.status = PolicyStatus.active}): super._();
  

@override final  String id;
@override final  String policyNumber;
@override final  String holderName;
@override final  String type;
@override final  double coverageAmount;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override@JsonKey() final  PolicyStatus status;

/// Create a copy of PolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PolicyModelCopyWith<_PolicyModel> get copyWith => __$PolicyModelCopyWithImpl<_PolicyModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PolicyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.policyNumber, policyNumber) || other.policyNumber == policyNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.type, type) || other.type == type)&&(identical(other.coverageAmount, coverageAmount) || other.coverageAmount == coverageAmount)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,policyNumber,holderName,type,coverageAmount,startDate,endDate,status);

@override
String toString() {
  return 'PolicyModel(id: $id, policyNumber: $policyNumber, holderName: $holderName, type: $type, coverageAmount: $coverageAmount, startDate: $startDate, endDate: $endDate, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PolicyModelCopyWith<$Res> implements $PolicyModelCopyWith<$Res> {
  factory _$PolicyModelCopyWith(_PolicyModel value, $Res Function(_PolicyModel) _then) = __$PolicyModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String policyNumber, String holderName, String type, double coverageAmount, DateTime startDate, DateTime endDate, PolicyStatus status
});




}
/// @nodoc
class __$PolicyModelCopyWithImpl<$Res>
    implements _$PolicyModelCopyWith<$Res> {
  __$PolicyModelCopyWithImpl(this._self, this._then);

  final _PolicyModel _self;
  final $Res Function(_PolicyModel) _then;

/// Create a copy of PolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? policyNumber = null,Object? holderName = null,Object? type = null,Object? coverageAmount = null,Object? startDate = null,Object? endDate = null,Object? status = null,}) {
  return _then(_PolicyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,policyNumber: null == policyNumber ? _self.policyNumber : policyNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,coverageAmount: null == coverageAmount ? _self.coverageAmount : coverageAmount // ignore: cast_nullable_to_non_nullable
as double,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PolicyStatus,
  ));
}


}

// dart format on
