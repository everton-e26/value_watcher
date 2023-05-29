Super simple Builder widget to listen ValueNotifier changes


## Using

define your ValueNotifier

```dart
final counter = ValueNotifier(0);
```

use a `context.watch` inside a `WatcherBuilder` to listen changes

```dart
WatcherBuilder(
    builder: (context) {
        final value = context.watch(counter);
        return Text('value $value');
    },
)
```