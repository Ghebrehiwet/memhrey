// lib/screens/shared/congrats_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/progress_provider.dart';
 
class CongratsScreen extends StatefulWidget {
  const CongratsScreen({super.key});
 
  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}
 
class _CongratsScreenState extends State<CongratsScreen> {
  late ConfettiController _confetti;
 
  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 8));
    _confetti.play();
  }
 
  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  // Build a pw.TextStyle using the Tigrigna font
pw.TextStyle _ti(pw.Font font, double size, {PdfColor? color}) =>
    pw.TextStyle(font: font, fontSize: size, color: color);

// Build a pw.TextStyle for English (built-in font)
pw.TextStyle _en(double size, {PdfColor? color, bool bold = false}) =>
    pw.TextStyle(
        fontSize: size,
        fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        color: color);
 
   
  String _shareText(String name, int xp) =>
      '🎉 ሕጂ 4 ደረጃታት ናይ ትግራኛ መምህረይ ትምህርቲ ኣፕ ወዲአ! \n I just completed all 4 levels of the Memhrey Tigrigna Learning App!\n'
      '👤 $name\n⭐ $xp XP ኣኪበ\n🗓 ${DateFormat('MMMM d, yyyy').format(DateTime.now())}$name\n⭐ $xp XP earned\n🗓 ${DateFormat('MMMM d, yyyy').format(DateTime.now())}\n'
      '#Tigrigna #Memhrey #ትግርኛ';

  Future<void> _shareAchievement(String name, int xp) async {
    await Share.share(_shareText(name, xp), subject: 'I completed Memhrey Tigrigna!');
  }

  Future<void> _shareToFacebook(String name, int xp) async {
    final text = Uri.encodeComponent(_shareText(name, xp));
    final url = Uri.parse('https://www.facebook.com/sharer/sharer.php?u=https://memhrey.app&quote=$text');
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<void> _shareToTwitter(String name, int xp) async {
    final text = Uri.encodeComponent(_shareText(name, xp));
    final url = Uri.parse('https://twitter.com/intent/tweet?text=$text');
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<void> _shareToWhatsApp(String name, int xp) async {
    final text = Uri.encodeComponent(_shareText(name, xp));
    final url = Uri.parse('https://wa.me/?text=$text');
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  
  Future<void> _generateCertificate(String name) async {
  try {
    final pdf = pw.Document();
    final now = DateFormat('MMMM dd, yyyy').format(DateTime.now());

    final fontData = await rootBundle.load('assets/fonts/AbyssinicaSIL-Regular.ttf');
    final tiFont = pw.Font.ttf(fontData);

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (pw.Context ctx) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.amber700, width: 6),
          ),
          padding: const pw.EdgeInsets.all(40),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('CERTIFICATE OF COMPLETION',
                  style: _en(22, bold: true)),
              pw.SizedBox(height: 6),
              pw.Text('ናይ ምዝዛም ምስክር ወረቐት',
                  style: _ti(tiFont, 15, color: PdfColors.teal700)),
              pw.SizedBox(height: 20),
              pw.Text('BERHAN ACADEMY certifies that ', style: _en(14)),
              pw.SizedBox(height: 10),
              pw.Text(name,
                  style: _en(32, bold: true, color: PdfColors.deepPurple)),
              pw.SizedBox(height: 10),
              pw.Text('has successfully completed the', style: _en(14)),
              pw.SizedBox(height: 8),
              pw.Text('TIGRIGNA LANGUAGE LEARNING PROGRAM',
                  style: _en(18, bold: true, color: PdfColors.teal700)),
              pw.SizedBox(height: 6),
              pw.Text('ቋንቋ ትግርኛ ምምሃር ፕሮግራም',
                  style: _ti(tiFont, 16, color: PdfColors.teal700)),
              pw.SizedBox(height: 16),
              pw.Text('Covering:\n Alphabets  *  Words  *  Sentences  *  Paragraphs',
                  style: _en(12, color: PdfColors.grey700)),
              pw.SizedBox(height: 6),
              pw.Text('ፊደላት  *  ቃላት  *  ምሉእ ሓሳባት  *  ሕጡበ ጽሑፋት',
                  style: _ti(tiFont, 14, color: PdfColors.grey700)),
              pw.SizedBox(height: 24),
              pw.Divider(color: PdfColors.amber),
              pw.SizedBox(height: 12),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Awarded on $now', style: _en(11, color: PdfColors.grey600)),
                  pw.BarcodeWidget(
                    barcode: pw.Barcode.qrCode(),
                    data: 'https://memhrey.app/verify?name=${Uri.encodeComponent(name)}&date=$now',
                    width: 60,
                    height: 60,
                    color: PdfColors.deepPurple,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ));

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  } catch (e) {
    debugPrint('Certificate error: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not generate certificate: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
 
  @override
  Widget build(BuildContext context) {
    final name = context.watch<ProgressProvider>().studentName;
    final xp = context.watch<ProgressProvider>().totalXP;
 
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A3C),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text('🏆', style: TextStyle(fontSize: 80))
                      .animate().scale(duration: 800.ms, curve: Curves.elasticOut)
                      .then().shake(),
                  const SizedBox(height: 20),
                  const Text(
                    'እንቋዕ ሓጎሰኩም!',
                    style: TextStyle(
                      fontFamily: 'AbyssinicaSIL',
                      color: Colors.amber,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.3),
                  const SizedBox(height: 8),
                  const Text(
                    'Congratulations!',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C4DFF), Color(0xFF5C35CC)],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.amber, width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.amber.withOpacity(0.3),
                            blurRadius: 20, spreadRadius: 2)
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(name.isEmpty ? 'Student' : name,
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 8),
                        const Text(
                          'ቋንቋ ትግርኛ መሊኽኩም ኣለኹም\nYou have mastered the Tigrigna Language!\n\nኣብ ኣርባዕተ ደረጃታት ትምህርቲ ብትግሃት ሰሪሕኩም።\nYou worked diligently on four levels of education!',
                          style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: _statItem('✅', '4', 'ደረጃታት - Levels')),
                            Expanded(child: _statItem('⭐', '$xp', 'ሽልማት - XP Earned')),
                            Expanded(child: _statItem('🎯', '100%', 'ተዛዚሙ - Complete')),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (i) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              ['🔤', '📝', '💬', '📖'][i],
                              style: const TextStyle(fontSize: 28),
                            ).animate(delay: (i * 150 + 500).ms)
                                .scale(duration: 400.ms, curve: Curves.elasticOut),
                          )),
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: 0.3, delay: 500.ms, duration: 700.ms, curve: Curves.easeOut),
                  const SizedBox(height: 28),
                  ElevatedButton.icon(
                    onPressed: () => _generateCertificate(name),
                    icon: const Icon(Icons.download_rounded),
                    label: const Text('ምስክር ወረቐት - Download Certificate', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                    ),
                  // ).animate().scale(delay: 900.ms, duration: 500.ms, curve: Curves.elasticOut),
                  // const SizedBox(height: 16),
                  // TextButton(

                  ).animate().scale(delay: 900.ms, duration: 500.ms, curve: Curves.elasticOut),
                  const SizedBox(height: 20),

                  // Share section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      children: [
                        const Text('ንካልኦት ኣካፍል ወይ ሓብር - Share your achievement!',
                            style: TextStyle(fontFamily: 'AbyssinicaSIL', color: Colors.white70, fontSize: 13)),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                          child: QrImageView(
                            data: 'https://memhrey.app/certificate?name=${Uri.encodeComponent(name)}&xp=$xp&date=${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                            version: QrVersions.auto,
                            size: 140,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Scan to verify certificate', style: TextStyle(color: Colors.white38, fontSize: 11)),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _SocialBtn(icon: Icons.share, label: 'Share', color: Colors.blueAccent,
                                  onTap: () => _shareAchievement(name, xp)),
                            ),
                            Expanded(
                              child: _SocialBtn(emoji: '📘', label: 'Facebook', color: const Color(0xFF1877F2),
                                  onTap: () => _shareToFacebook(name, xp)),
                            ),
                            Expanded(
                              child: _SocialBtn(emoji: '🐦', label: 'Twitter', color: const Color(0xFF1DA1F2),
                                  onTap: () => _shareToTwitter(name, xp)),
                            ),
                            Expanded(
                              child: _SocialBtn(emoji: '💬', label: 'WhatsApp', color: const Color(0xFF25D366),
                                  onTap: () => _shareToWhatsApp(name, xp)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                    child: const Text('ናብ መበገሲ ቦታ ንድሕሪት ተመለስ - Back to Home', style: TextStyle(color: Colors.white54)),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 50,
              colors: const [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.pink, Colors.yellow],
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _statItem(String emoji, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 11),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;
  final String? emoji;

  const _SocialBtn({required this.label, required this.color, required this.onTap, this.icon, this.emoji});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: color, shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))],
            ),
            child: Center(
              child: emoji != null
                  ? Text(emoji!, style: const TextStyle(fontSize: 22))
                  : Icon(icon, color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}