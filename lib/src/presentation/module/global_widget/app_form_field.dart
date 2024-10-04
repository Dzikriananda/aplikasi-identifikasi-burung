import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef callChildMethod = void Function(BuildContext context, void Function() method);

class AppFormField extends StatefulWidget {
  AppFormField({
    Key? key,
    required this.hintText,
    this.fieldController,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.initialValue,
    this.validateTextField,
    this.method
  }) : super(key: key);
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  callChildMethod? method;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextEditingController? fieldController;
  bool obscureText;
  VoidCallback? validateTextField;

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool hide = true;
  late FocusNode myFocusNode;


  hideText() {
    setState(() {
      hide = !hide;
    });
  }

  @override void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      if(!myFocusNode.hasFocus){
        widget.validateTextField;
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.method?.call(context,hideText);
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: TextFormField(
        focusNode: myFocusNode,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        obscureText: (widget.obscureText) ? hide : false,
        controller: widget.fieldController,
        initialValue: widget.initialValue,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: false, //<-- SEE HER
          fillColor: Theme.of(context).colorScheme.surfaceVariant,
          suffixIcon: widget.suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurfaceVariant),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurfaceVariant),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurfaceVariant),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder:  OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurfaceVariant),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurfaceVariant),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
