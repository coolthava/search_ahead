import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OverflowTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? cursorColor;
  final TextStyle? style;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final InputDecoration? decoration;

  final bool expands;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final GestureTapCallback? onTap;
  final MaxLengthEnforcement? maxLengthEnforcement;

  final bool? enabled;
  final bool readOnly;
  final double? cursorHeight;
  final bool enableInteractiveSelection;
  final List<TextInputFormatter>? inputFormatters;
  final bool? showCursor;

  const OverflowTextField(
      {this.controller,
      this.keyboardType,
      this.cursorColor,
      this.style,
      this.focusNode,
      this.onChanged,
      this.decoration,
      this.expands = false,
      this.maxLines,
      this.autofocus = false,
      this.textInputAction,
      this.textCapitalization = TextCapitalization.none,
      this.onTap,
      this.enabled,
      this.readOnly = false,
      this.cursorHeight,
      this.enableInteractiveSelection = true,
      this.inputFormatters,
      this.minLines,
      this.maxLengthEnforcement,
      this.showCursor,
      Key? key})
      : super(key: key);

  @override
  _OverflowTextFieldState createState() => _OverflowTextFieldState();
}

class _OverflowTextFieldState extends State<OverflowTextField> {
  var _currentText = '';
  late FocusNode _focusNode;
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _editingController.clear();
      } else {
        _editingController.text = _currentText;
        _editingController.selection = TextSelection.fromPosition(
            TextPosition(offset: _currentText.length));
      }
    });

    _currentText = widget.controller?.text ?? '';
    widget.controller?.addListener(() {
      if (widget.controller?.text != _currentText) {
        _currentText = widget.controller?.text ?? '';
        _editingController.text = _currentText;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var decoration = widget.decoration ?? const InputDecoration();

    if (_currentText.isNotEmpty) {
      decoration =
          decoration.copyWith(hintText: _currentText, hintStyle: widget.style);
    }

    return TextField(
      enableInteractiveSelection: widget.enableInteractiveSelection,
      inputFormatters: widget.inputFormatters,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      expands: widget.expands,
      minLines: widget.minLines,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      controller: _editingController,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      cursorHeight: widget.cursorHeight,
      cursorColor: widget.cursorColor,
      style: widget.style,
      onChanged: (text) {
        _currentText = text;
        widget.controller?.text = _currentText;
        widget.onChanged?.call(text);
      },
      focusNode: _focusNode,
      decoration: decoration,
      showCursor: widget.showCursor,
    );
  }
}
