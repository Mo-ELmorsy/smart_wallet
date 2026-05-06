
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';

class PdfExportService {
  static Future<void> exportMonthlyReport({
    required DateTime month,
    required double totalIncome,
    required double totalExpense,
    required Map<String, double> categoryExpenses,
    required List<Transaction> transactions,
  }) async {
    final pdf = pw.Document();
    
    // Attempt to load a font if needed, otherwise rely on default
    final monthYear = DateFormat.yMMMM().format(month);
    final netBalance = totalIncome - totalExpense;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            _buildHeader(monthYear),
            pw.SizedBox(height: 20),
            _buildSummary(totalIncome, totalExpense, netBalance),
            pw.SizedBox(height: 20),
            _buildTopCategories(categoryExpenses),
            pw.SizedBox(height: 20),
            _buildTransactionsTable(transactions),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'SmartWallet_Report_$monthYear.pdf',
    );
  }

  static pw.Widget _buildHeader(String monthYear) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('SmartWallet', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue)),
        pw.SizedBox(height: 4),
        pw.Text('Monthly Financial Report - $monthYear', style: const pw.TextStyle(fontSize: 16, color: PdfColors.grey700)),
        pw.Divider(),
      ],
    );
  }

  static pw.Widget _buildSummary(double income, double expense, double net) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: const pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          _summaryItem('Total Income', income, PdfColors.green700),
          _summaryItem('Total Expenses', expense, PdfColors.red700),
          _summaryItem('Net Balance', net, net >= 0 ? PdfColors.blue700 : PdfColors.red700),
        ],
      ),
    );
  }

  static pw.Widget _summaryItem(String title, double amount, PdfColor color) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
        pw.SizedBox(height: 4),
        pw.Text('\$${amount.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: color)),
      ],
    );
  }

  static pw.Widget _buildTopCategories(Map<String, double> categoryExpenses) {
    if (categoryExpenses.isEmpty) return pw.SizedBox();

    final sorted = categoryExpenses.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final top = sorted.take(5).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Top Spending Categories', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        ...top.map((e) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(e.key, style: const pw.TextStyle(fontSize: 12)),
            pw.Text('\$${e.value.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 12, color: PdfColors.red700)),
          ]
        )),
      ]
    );
  }

  static pw.Widget _buildTransactionsTable(List<Transaction> transactions) {
    if (transactions.isEmpty) return pw.Text('No transactions for this month.');

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Transactions', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.TableHelper.fromTextArray(
          headers: ['Date', 'Category', 'Type', 'Amount', 'Note'],
          data: transactions.map((tx) {
            final date = DateFormat('yyyy-MM-dd').format(tx.date);
            final typeStr = tx.type == TransactionType.income ? 'Income' : 'Expense';
            final amtStr = '\$${tx.amount.toStringAsFixed(2)}';
            return [date, tx.categoryName ?? 'Unknown', typeStr, amtStr, tx.note ?? ''];
          }).toList(),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey700),
          rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: .5))),
          cellAlignment: pw.Alignment.centerLeft,
        ),
      ]
    );
  }
}
