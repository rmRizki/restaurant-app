import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/styles/colors.dart';

class ScrollFloatingActionButton extends StatefulWidget {
  final ScrollController scrollController;

  ScrollFloatingActionButton({@required this.scrollController});

  @override
  _ScrollFloatingActionButtonState createState() =>
      _ScrollFloatingActionButtonState();
}

class _ScrollFloatingActionButtonState
    extends State<ScrollFloatingActionButton> {
  ScrollController _scrollController;
  bool _isVisible;

  @override
  void initState() {
    _isVisible = false;
    _scrollController = widget.scrollController;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 0.1) {
        if (_isVisible == true) {
          setState(() => _isVisible = false);
        }
      } else {
        if (_isVisible == false) {
          setState(() => _isVisible = true);
        }
      }
    });
    super.initState();
  }

  _scrollUp() async {
    if (_scrollController.hasClients) {
      await Future.delayed(Duration(milliseconds: 50), () {
        _scrollController?.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: _isVisible ? 1 : 0,
      child: FloatingActionButton(
        onPressed: _scrollUp,
        child: Icon(Icons.arrow_upward, color: white),
      ),
    );
  }
}
