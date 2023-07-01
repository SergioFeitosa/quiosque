// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension CategoryStateStatusMatch on CategoryStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == CategoryStateStatus.initial) {
      return initial();
    }

    if (v == CategoryStateStatus.loading) {
      return loading();
    }

    if (v == CategoryStateStatus.loaded) {
      return loaded();
    }

    if (v == CategoryStateStatus.error) {
      return error();
    }

    throw Exception(
        'CategoryStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == CategoryStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == CategoryStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == CategoryStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == CategoryStateStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
