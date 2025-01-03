import 'package:flutter/material.dart';

class OffsetListTile extends StatefulWidget {
  final Offset value;
  final ValueChanged<Offset> onChanged;
  final Widget? title, subtitle, leading, trailing;
  final int fractionDigits;

  const OffsetListTile({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.fractionDigits = 2,
  });

  @override
  State<OffsetListTile> createState() => _OffsetListTileState();
}

class _OffsetListTileState extends State<OffsetListTile> {
  final TextEditingController _xController = TextEditingController(),
      _yController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _updateValue(widget.value);
  }

  @override
  void didUpdateWidget(covariant OffsetListTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _updateValue(widget.value);
    }
  }

  void _updateValue(Offset value) {
    _xController.text = value.dx.toStringAsFixed(widget.fractionDigits);
    _yController.text = value.dy.toStringAsFixed(widget.fractionDigits);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: widget.title,
        subtitle: widget.subtitle,
        leading: widget.leading,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.trailing != null) ...[
              widget.trailing!,
              const SizedBox(width: 4),
            ],
            SizedBox(
              width: 100,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'X',
                  filled: true,
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _xController,
                onChanged: (value) {
                  widget
                      .onChanged(Offset(double.parse(value), widget.value.dy));
                },
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 100,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Y',
                  filled: true,
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _yController,
                onChanged: (value) {
                  widget
                      .onChanged(Offset(double.parse(value), widget.value.dy));
                },
              ),
            ),
          ],
        ));
  }
}
