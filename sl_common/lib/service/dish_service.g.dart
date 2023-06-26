// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$menuServiceHash() => r'40b1221bd143bdabae1786187627d938d266af4b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef MenuServiceRef = AutoDisposeFutureProviderRef<List<Dish>>;

/// See also [menuService].
@ProviderFor(menuService)
const menuServiceProvider = MenuServiceFamily();

/// See also [menuService].
class MenuServiceFamily extends Family<AsyncValue<List<Dish>>> {
  /// See also [menuService].
  const MenuServiceFamily();

  /// See also [menuService].
  MenuServiceProvider call(
    FirebaseFirestore? instance,
  ) {
    return MenuServiceProvider(
      instance,
    );
  }

  @override
  MenuServiceProvider getProviderOverride(
    covariant MenuServiceProvider provider,
  ) {
    return call(
      provider.instance,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'menuServiceProvider';
}

/// See also [menuService].
class MenuServiceProvider extends AutoDisposeFutureProvider<List<Dish>> {
  /// See also [menuService].
  MenuServiceProvider(
    this.instance,
  ) : super.internal(
          (ref) => menuService(
            ref,
            instance,
          ),
          from: menuServiceProvider,
          name: r'menuServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$menuServiceHash,
          dependencies: MenuServiceFamily._dependencies,
          allTransitiveDependencies:
              MenuServiceFamily._allTransitiveDependencies,
        );

  final FirebaseFirestore? instance;

  @override
  bool operator ==(Object other) {
    return other is MenuServiceProvider && other.instance == instance;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, instance.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
