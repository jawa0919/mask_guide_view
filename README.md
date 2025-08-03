# MaskGuideView

[![Pub package](https://img.shields.io/pub/v/mask_guide_view.svg)](https://pub.dartlang.org/packages/mask_guide_view) [![GitHub issues](https://img.shields.io/github/issues/jawa0919/mask_guide_view)](https://github.com/jawa0919/mask_guide_view/issues)

## Getting started

Mask Guide View

[Example-Web](https://jawa0919.github.io/mask_guide_view/)

## Usage

```yaml
dependencies:
  mask_guide_view: any
```

## Additional information

```dart
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
```
