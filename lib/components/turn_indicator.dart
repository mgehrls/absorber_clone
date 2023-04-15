import 'package:flutter/material.dart';

class TurnIndicator extends StatefulWidget {
  final int duration;
  final Function onProgressComplete;
  final bool isPlaying;

  const TurnIndicator({
    Key? key,
    required this.duration,
    required this.onProgressComplete,
    required this.isPlaying,
  }) : super(key: key);

  @override
  _TurnIndicatorState createState() => _TurnIndicatorState();
}

class _TurnIndicatorState extends State<TurnIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController)
      ..addListener(() {
        if (_animationController.isCompleted) {
          widget.onProgressComplete();
          _animationController.reset();
          if (widget.isPlaying == true) {
            _animationController.forward();
          }
        }
        setState(() {});
      });

    if (widget.isPlaying == true) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: ValueKey(widget.duration),
      width: 200,
      child: LinearProgressIndicator(
        value: _animation.value,
        backgroundColor: Colors.grey,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }

  @override
  void didUpdateWidget(TurnIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying == true) {
        _animationController.forward();
      } else {
        _animationController.reset();
      }
    }
    if (widget.duration != oldWidget.duration) {
      _animationController.duration = Duration(milliseconds: widget.duration);
    }
  }
}
