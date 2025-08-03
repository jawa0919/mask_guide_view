import 'dart:math';

import 'package:flutter/material.dart';

typedef MaskGuideListener = void Function(bool show);

typedef MaskGuideBuilder = Widget Function(
  BuildContext context,
  MaskGuideController controller,
);

class MaskGuideAlignment {
  final Alignment targetAnchor;
  final Alignment followerAnchor;

  const MaskGuideAlignment(this.targetAnchor, this.followerAnchor);

  static const MaskGuideAlignment left = MaskGuideAlignment(
    Alignment.centerLeft,
    Alignment.centerRight,
  );
  static const MaskGuideAlignment top = MaskGuideAlignment(
    Alignment.topCenter,
    Alignment.bottomCenter,
  );
  static const MaskGuideAlignment right = MaskGuideAlignment(
    Alignment.centerRight,
    Alignment.centerLeft,
  );
  static const MaskGuideAlignment bottom = MaskGuideAlignment(
    Alignment.bottomCenter,
    Alignment.topCenter,
  );

  Offset getOffset(double size, Offset offset) {
    Offset temp = Offset.zero;
    if (this == left) {
      temp = temp.translate(-size * 0.5 - 4, 0);
      temp = temp.translate(0, offset.dy);
    }
    if (this == top) {
      temp = temp.translate(0, -size * 0.5 - 4);
      temp = temp.translate(offset.dx, 0);
    }
    if (this == right) {
      temp = temp.translate(size * 0.5 + 4, 0);
      temp = temp.translate(0, offset.dy);
    }
    if (this == bottom) {
      temp = temp.translate(0, size * 0.5 + 4);
      temp = temp.translate(offset.dx, 0);
    }
    return temp;
  }
}

class MaskGuideController {
  bool _show;
  MaskGuideController({bool? show}) : _show = show ?? false;

  bool get show => _show;
  set show(bool newVal) {
    if (_show != newVal) {
      _show = newVal;
      for (var listener in _listeners) {
        listener(_show);
      }
    }
  }

  final List<void Function(bool)> _listeners = [];
  void addListener(MaskGuideListener listener) {
    _listeners.add(listener);
  }

  void removeListener(MaskGuideListener listener) {
    _listeners.remove(listener);
  }

  void removeAllListener() {
    _listeners.clear();
  }
}

class MaskGuideView extends StatefulWidget {
  final MaskGuideController? controller;
  final Widget child;
  final MaskGuideBuilder maskGuideBuilder;
  final MaskGuideListener? onChange;
  final MaskGuideAlignment alignment;
  final Color color;
  final Color overlayColor;
  final double borderRadius;
  final double triangleSize;
  final Offset offset;

  const MaskGuideView({
    super.key,
    this.controller,
    required this.child,
    required this.maskGuideBuilder,
    this.onChange,
    this.alignment = MaskGuideAlignment.top,
    this.color = const Color(0xFFFFFFFF),
    this.overlayColor = const Color(0x88000000),
    this.borderRadius = 10,
    this.triangleSize = 20,
    this.offset = Offset.zero,
  });

  @override
  State<MaskGuideView> createState() => _MaskGuideViewState();
}

class _MaskGuideViewState extends State<MaskGuideView> {
  final _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  late MaskGuideController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? MaskGuideController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayEntry = _createOverlayEntry(context);
      _controller.addListener((show) {
        if (show) {
          Overlay.of(context).insert(_overlayEntry);
        } else {
          _overlayEntry.remove();
        }
      });
      if (_controller.show) {
        Overlay.of(context).insert(_overlayEntry);
      }
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: widget.overlayColor,
          ),
          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              child: IgnorePointer(child: widget.child),
            ),
          ),
          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: widget.alignment.targetAnchor,
              followerAnchor: widget.alignment.followerAnchor,
              offset: widget.alignment.getOffset(
                widget.triangleSize,
                Offset.zero,
              ),
              child: Transform.rotate(
                angle: pi / 4,
                child: Container(
                  width: widget.triangleSize * 1.414,
                  height: widget.triangleSize * 1.414,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: widget.alignment.targetAnchor,
              followerAnchor: widget.alignment.followerAnchor,
              offset: widget.alignment.getOffset(
                widget.triangleSize,
                widget.offset,
              ),
              child: Stack(
                alignment: widget.alignment.followerAnchor,
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    color: widget.color,
                    child: widget.maskGuideBuilder(context, _controller),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.removeAllListener();
    super.dispose();
  }
}
