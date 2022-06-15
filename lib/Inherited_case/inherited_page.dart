import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const InheritedPageTest());
}

class InheritedPageTest extends StatelessWidget {
  const InheritedPageTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Center(
          child: _InheritedPage(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                _WidgetA(),
                _WidgetA1(),
                _WidgetA2(),
                _WidgetB(),
                _WidgetC(),
                _WidgetD(),
                _WidgetE(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///该部件不会重建
class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.widget_wont_rebuild);
  }
}
///该部件不会重建
class _WidgetA1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.widget_wont_rebuild);
  }
}
///该部件不会重建
class _WidgetA2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.widget_wont_rebuild);
  }
}
///该部件在父组件重建时会重建
class _WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = _InheritedPage.of(context);
    return Text(
      '${state.count}',
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

///该部件在父组件重建时会重建
class _WidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = _InheritedPage.of(context);
    return Text(
      '${state.count}',
      style: TextStyle(
          color: state.isColorRed ? Colors.red : Colors.green, fontSize: 50),
    );
  }
}
///该部件在父组件重建时不会重建
class _WidgetD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = _InheritedPage.of(context, rebuild: false);
    return ElevatedButton(
        onPressed: () => state._increaseCount(),
        child: const Icon(
          Icons.add,
        ));
  }
}
///该部件在父组件重建时不会重建
class _WidgetE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = _InheritedPage.of(context, rebuild: false);
    return ElevatedButton(
        onPressed: () {
          state._changeColor();
        },
        child: Text(AppLocalizations.of(context)!.color_change));
  }
}
///缓存组件自定义类，在[setState]重构widget时，仅仅和缓存变量相关的widget重构，其他子widget不重构
class _InheritedPage extends StatefulWidget {
  const _InheritedPage({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  State<StatefulWidget> createState() => _InheritedPageState();

  static _InheritedPageState of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return (context
          .dependOnInheritedWidgetOfExactType<_MyInheritedWidget>() as _MyInheritedWidget)
          .state;
    }
    return (context
            .getElementForInheritedWidgetOfExactType<_MyInheritedWidget>()
            ?.widget as _MyInheritedWidget)
        .state;
  }
}

class _InheritedPageState extends State<_InheritedPage> {
  int count = 0;
  bool isColorRed = true;

  ///增加count
  void _increaseCount() {
    setState(() => ++count);
  }

  ///改变颜色
  void _changeColor() {
    setState(() => isColorRed = !isColorRed);
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      this,
      child: widget.child,
    );
  }
}

class _MyInheritedWidget extends InheritedWidget {
  const _MyInheritedWidget(this.state, {Key? key, required Widget child})
      : super(key: key, child: child);

  final _InheritedPageState state;

  ///是否通知子widget重建
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
