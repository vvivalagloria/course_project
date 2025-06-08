import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityBanner extends StatefulWidget {
  const ConnectivityBanner({Key? key}) : super(key: key);

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner> {
  bool _offline = false;
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _sub = Connectivity()
        .onConnectivityChanged
        .listen((result) => setState(() {
      _offline = result == ConnectivityResult.none;
    }));
  }

  @override
  Widget build(BuildContext context) {
    if (!_offline) return const SizedBox.shrink();
    return MaterialBanner(
      content: const Text('No internet connection'),
      leading: const Icon(Icons.wifi_off),
      actions: const [],
    );
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}