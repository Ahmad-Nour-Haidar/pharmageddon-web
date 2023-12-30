/// Create a Pair
///
/// [K] is type of [key]
///
/// [V] is type of [value]
///
/// [key] and [value] with same pair can create a list
class Pair<K, V> {
  final K key;
  final V value;

  const Pair(this.key, this.value);

  /// deserialized pair
  (K, V) call() {
    return (key, value);
  }

  /// Pair to Map
  Map<K, V> get toMap {
    return <K, V>{
      key: value,
    };
  }

  /// Pair to MapEntry
  MapEntry<K, V> get toMapEntry {
    return MapEntry(
      key,
      value,
    );
  }

  /// reverse pair
  ///
  /// [key] will be the [value] and vice versa
  Pair<V, K> get reverse {
    return Pair<V, K>(
      value,
      key,
    );
  }

  /// copy with function
  ///
  /// [key] and [value] are optional
  ///
  /// if no value are supplied will take the instance value
  Pair<K, V> copyWith({
    K? key,
    V? value,
  }) {
    return Pair(
      key ?? this.key,
      value ?? this.value,
    );
  }

  /// mutate this pair into another pair with difference type
  ///
  /// [f] is your mutation function
  Pair<A, B> mutate<A, B>(Pair<A, B> Function(K key, V value) f) {
    return f(
      key,
      value,
    );
  }

  /// transform pair to new value with [A] type
  ///
  /// [f] is your function to transform into new value
  A transform<A>(A Function(K key, V value) f) {
    return f(
      key,
      value,
    );
  }

  @override
  String toString() {
    return "Pair($key, $value)";
  }

  @override
  bool operator ==(other) {
    if (other is! Pair) {
      return false;
    }
    return other.key.runtimeType == key.runtimeType &&
        other.key == key &&
        other.value.runtimeType == value.runtimeType &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(
        key,
        value,
      );
}

extension PairExtension<T> on Pair<T, T> {
  List<T> get toList {
    assert(key.runtimeType == value.runtimeType,
        "key and value do not have same type");
    return [key, value];
  }
}
