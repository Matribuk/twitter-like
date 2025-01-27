import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final Future<bool> Function(List<String> params) handleAction;
  final List<TextEditingController> paramsController;
  final List<int> allowedEmpty;
  const SubmitButton({
    super.key,
    required this.handleAction,
    required this.paramsController,
    this.allowedEmpty = const [],
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool isLoading = false;

  Future<void> _submitForm() async {
    final paramsController = widget.paramsController;

    setState(() {
      isLoading = true;
    });

    try {
      List<String> params = [];
      for (var controller in paramsController) {
        if (controller.text.isEmpty && !widget.allowedEmpty.contains(paramsController.indexOf(controller))) {
          throw Exception('Empty field');
        }
        params.add(controller.text);
      }
      final success = await widget.handleAction(params);
      if (success) {
        if (kDebugMode) print('Action successful');
      } else {
        if (kDebugMode) print('Action failed');
      }
    } catch (e) {
      if (kDebugMode) print('Error during action: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () {
              _submitForm();
            },
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            )
          : const Text('Submit'),
    );
  }
}
