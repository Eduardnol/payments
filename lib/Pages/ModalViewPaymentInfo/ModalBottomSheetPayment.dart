import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/PaymentObject.dart';
import '../../services/AuthService.dart';
import 'PaymentItemView.dart';

class ModalBottomSheetPayment extends StatelessWidget {
  final PaymentItemObject paymentItemObject;
  final VoidCallback? onPaymentUpdated; // Callback para notificar cambios

  const ModalBottomSheetPayment({
    super.key,
    required this.paymentItemObject,
    this.onPaymentUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        elevation: 0,
        title: Text("${paymentItemObject.title} Details"),
        actions: [
          TextButton.icon(
            onPressed: () => _savePayment(context),
            icon: const Icon(Icons.save),
            label: const Text("Save"),
          ),
        ],
        leading: IconButton(
          onPressed: () => _askForDiscardConfirmation(context),
          icon: const Icon(Icons.close),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: SingleChildScrollView(
          child: PaymentItemView(paymentItemObject: paymentItemObject)),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
          onPressed: () => _askForDeleteConfirmation(context),
          child: Text(
            "Delete",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer),
          ),
        ),
      ),
    );
  }

  Future<void> _savePayment(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      // Mostrar indicador de progreso
      _showLoadingDialog(context, "Saving...");

      final uid = await context.read<AuthService>().getCurrentUID();
      // Convertir el IconData a un entero para almacenarlo en Firestore
      final iconData = paymentItemObject.icon.icon?.codePoint ?? 11111;

      await FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .collection('payments')
          .doc(paymentItemObject.id.id)
          .set({
        'title': paymentItemObject.title,
        'price': paymentItemObject.price,
        'description': paymentItemObject.description,
        'date': paymentItemObject.date,
        'category': paymentItemObject.category,
        'createdOn': paymentItemObject.createdOn.toString(),
        'iconCodePoint': iconData, // Guardar el código del icono
      });

      // Cerrar diálogo de carga
      navigator.pop();

      // Llamar al callback si existe
      if (onPaymentUpdated != null) {
        onPaymentUpdated!();
      }

      // Cerrar modal de pago
      navigator.pop();

      scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text("Payment Updated!"),
        duration: Duration(seconds: 2),
      ));
    } catch (error) {
      // Cerrar diálogo de carga si hay error
      navigator.pop();

      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text("Error: ${error.toString()}"),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  Future<void> _deletePayment(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      // Mostrar indicador de progreso
      _showLoadingDialog(context, "Deleting...");

      final uid = await context.read<AuthService>().getCurrentUID();

      await FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .collection('payments')
          .doc(paymentItemObject.id.id)
          .delete();

      // Cerrar diálogo de carga
      navigator.pop();

      // Llamar al callback si existe
      if (onPaymentUpdated != null) {
        onPaymentUpdated!();
      }

      // Cerrar modal de pago
      navigator.pop();

      scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text("Payment deleted successfully"),
        duration: Duration(seconds: 2),
      ));
    } catch (error) {
      // Cerrar diálogo de carga si hay error
      navigator.pop();

      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text("Error: ${error.toString()}"),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  void _showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 20),
              Text(
                message,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
        );
      },
    );
  }

  void _askForDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Delete payment?",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Text(
          "Are you sure you want to delete this payment?",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deletePayment(context);
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _askForDiscardConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Discard changes?",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Text(
          "Are you sure you want to discard changes?",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              "Discard",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
