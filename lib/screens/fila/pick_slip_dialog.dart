import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../models/models.dart';

class PickSlipDialog extends StatelessWidget {
  final Order order;
  const PickSlipDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("COMPROVANTE DE SELEÇÃO (PICK SLIP)"),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ordem: ${order.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Destino: ${order.pointId}"),
            Text("Solicitante: ${order.requestedBy ?? 'N/A'}"),
            const Divider(),
            ...order.items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text("• [ ] ${item.quantity}x ${item.description}"),
            )),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("FECHAR")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900),
          onPressed: () => _generatePdf(order), // AGORA REFERENCIADO
          child: const Text("IMPRIMIR", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _generatePdf(Order order) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Header(level: 0, child: pw.Text("ZIRAN WEB - PICK SLIP")),
            pw.Text("Ordem de Movimentacao: ${order.id}"),
            pw.Text("Data: ${DateTime.now().toString()}"),
            pw.Text("Ponto de Destino: ${order.pointId}"),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ['Qtd', 'SKU', 'Descricao'],
              data: order.items.map((i) => [i.quantity.toString(), i.sku, i.description]).toList(),
            ),
            pw.SizedBox(height: 50),
            pw.Text("Assinatura Separador: ___________________________"),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}