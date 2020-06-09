
import 'package:flutter/material.dart';

class CameraState {
  bool menuPress=false;
  CameraState({
    this.menuPress = false,
  });
  @override
  String toString() {
    return 'CameraState{menuPress:$menuPress}}';
  }
}

class AppStateContainer extends StatefulWidget {
  final CameraState camstate;
  final Widget child;
  AppStateContainer({
    @required this.child,
    this.camstate,
  });
  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
    as _InheritedStateContainer)
        .data;
  }

  @override
  _AppStateContainerState createState() => new _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  CameraState cameraState;
  @override
  void initState() {
    cameraState = CameraState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}
class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}