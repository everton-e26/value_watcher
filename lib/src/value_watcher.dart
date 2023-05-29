import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class WatcherBuilder extends InheritedWidget {
  final Widget Function(BuildContext context) builder;
  late final _WatcherBuilderElement _element;

  WatcherBuilder({super.key, required this.builder})
      : super(child: Builder(builder: builder));

  @override
  InheritedElement createElement() {
    _element = _WatcherBuilderElement(this, builder);
    return _element;
  }

  @override
  bool updateShouldNotify(covariant WatcherBuilder oldWidget) => false;
}

class _WatcherBuilderElement extends InheritedElement {
  final Widget Function(BuildContext context) builder;
  final _listenables = <Listenable>[];
  _WatcherBuilderElement(super.widget, this.builder);

  @override
  Widget build() {
    return Builder(builder: builder);
  }

  @override
  void unmount() {
    _removeListeners();
    super.unmount();
  }

  void _handle() {
    markNeedsBuild();
  }

  void addListener(Listenable listenable) {
    _removeListeners();
    _listenables.add(listenable);
    listenable.addListener(_handle);
  }

  void _removeListeners() {
    for (var listenable in _listenables) {
      listenable.removeListener(_handle);
    }
  }
}

extension BuildContextExt on BuildContext {
  T listen<T>(ValueListenable<T> valueListenable) {
    final myBuilder = getInheritedWidgetOfExactType<WatcherBuilder>()!;
    myBuilder._element.addListener(valueListenable);
    return valueListenable.value;
  }
}
