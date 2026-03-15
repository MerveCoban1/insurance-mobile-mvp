// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClaimModel {

 String get id; String get policyId; DateTime get incidentDate; String get incidentDescription; ClaimStatus get status;
/// Create a copy of ClaimModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimModelCopyWith<ClaimModel> get copyWith => _$ClaimModelCopyWithImpl<ClaimModel>(this as ClaimModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimModel&&(identical(other.id, id) || other.id == id)&&(identical(other.policyId, policyId) || other.policyId == policyId)&&(identical(other.incidentDate, incidentDate) || other.incidentDate == incidentDate)&&(identical(other.incidentDescription, incidentDescription) || other.incidentDescription == incidentDescription)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,policyId,incidentDate,incidentDescription,status);

@override
String toString() {
  return 'ClaimModel(id: $id, policyId: $policyId, incidentDate: $incidentDate, incidentDescription: $incidentDescription, status: $status)';
}


}

/// @nodoc
abstract mixin class $ClaimModelCopyWith<$Res>  {
  factory $ClaimModelCopyWith(ClaimModel value, $Res Function(ClaimModel) _then) = _$ClaimModelCopyWithImpl;
@useResult
$Res call({
 String id, String policyId, DateTime incidentDate, String incidentDescription, ClaimStatus status
});




}
/// @nodoc
class _$ClaimModelCopyWithImpl<$Res>
    implements $ClaimModelCopyWith<$Res> {
  _$ClaimModelCopyWithImpl(this._self, this._then);

  final ClaimModel _self;
  final $Res Function(ClaimModel) _then;

/// Create a copy of ClaimModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? policyId = null,Object? incidentDate = null,Object? incidentDescription = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,policyId: null == policyId ? _self.policyId : policyId // ignore: cast_nullable_to_non_nullable
as String,incidentDate: null == incidentDate ? _self.incidentDate : incidentDate // ignore: cast_nullable_to_non_nullable
as DateTime,incidentDescription: null == incidentDescription ? _self.incidentDescription : incidentDescription // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClaimStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimModel].
extension ClaimModelPatterns on ClaimModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimModel value)  $default,){
final _that = this;
switch (_that) {
case _ClaimModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String policyId,  DateTime incidentDate,  String incidentDescription,  ClaimStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimModel() when $default != null:
return $default(_that.id,_that.policyId,_that.incidentDate,_that.incidentDescription,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String policyId,  DateTime incidentDate,  String incidentDescription,  ClaimStatus status)  $default,) {final _that = this;
switch (_that) {
case _ClaimModel():
return $default(_that.id,_that.policyId,_that.incidentDate,_that.incidentDescription,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String policyId,  DateTime incidentDate,  String incidentDescription,  ClaimStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ClaimModel() when $default != null:
return $default(_that.id,_that.policyId,_that.incidentDate,_that.incidentDescription,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _ClaimModel extends ClaimModel {
  const _ClaimModel({required this.id, required this.policyId, required this.incidentDate, required this.incidentDescription, required this.status}): super._();
  

@override final  String id;
@override final  String policyId;
@override final  DateTime incidentDate;
@override final  String incidentDescription;
@override final  ClaimStatus status;

/// Create a copy of ClaimModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimModelCopyWith<_ClaimModel> get copyWith => __$ClaimModelCopyWithImpl<_ClaimModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimModel&&(identical(other.id, id) || other.id == id)&&(identical(other.policyId, policyId) || other.policyId == policyId)&&(identical(other.incidentDate, incidentDate) || other.incidentDate == incidentDate)&&(identical(other.incidentDescription, incidentDescription) || other.incidentDescription == incidentDescription)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,policyId,incidentDate,incidentDescription,status);

@override
String toString() {
  return 'ClaimModel(id: $id, policyId: $policyId, incidentDate: $incidentDate, incidentDescription: $incidentDescription, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ClaimModelCopyWith<$Res> implements $ClaimModelCopyWith<$Res> {
  factory _$ClaimModelCopyWith(_ClaimModel value, $Res Function(_ClaimModel) _then) = __$ClaimModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String policyId, DateTime incidentDate, String incidentDescription, ClaimStatus status
});




}
/// @nodoc
class __$ClaimModelCopyWithImpl<$Res>
    implements _$ClaimModelCopyWith<$Res> {
  __$ClaimModelCopyWithImpl(this._self, this._then);

  final _ClaimModel _self;
  final $Res Function(_ClaimModel) _then;

/// Create a copy of ClaimModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? policyId = null,Object? incidentDate = null,Object? incidentDescription = null,Object? status = null,}) {
  return _then(_ClaimModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,policyId: null == policyId ? _self.policyId : policyId // ignore: cast_nullable_to_non_nullable
as String,incidentDate: null == incidentDate ? _self.incidentDate : incidentDate // ignore: cast_nullable_to_non_nullable
as DateTime,incidentDescription: null == incidentDescription ? _self.incidentDescription : incidentDescription // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClaimStatus,
  ));
}


}

// dart format on
