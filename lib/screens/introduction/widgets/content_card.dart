import 'package:github_test/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContentCard extends StatefulWidget {
  final String color;
  final Color altColor, altTextColor, bgColor, fontColor;
  final String title;
  final String subtitle;
  final onClick;

  ContentCard(
      {this.color,
      this.title = "",
      this.subtitle,
      this.altColor,
      this.bgColor,
      this.onClick,
      this.fontColor,
      this.altTextColor})
      : super();

  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  // Ticker _ticker;

  @override
  void initState() {
    // _ticker = Ticker((d) {
    //   setState(() {});
    // })
    //   ..start();
    super.initState();
  }

  @override
  void dispose() {
    // _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          height: size.height,
          width: size.width,
          color: widget.bgColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 75.0, bottom: 25.0),
          child: Column(
            children: <Widget>[
              //Top Image
              Expanded(
                flex: 3,
                child: Center(
                  child: Container(
                      width: size.width / 1.1,
                      height: size.width / 1.1,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size.width),
                          color: Colors.white.withOpacity(0.3)),
                      child: SvgPicture.asset(
                        'assets/images/Illustration-${widget.color}.svg',
                      )),
                ),
              ),

              //Slider circles
              Container(
                  height: 14,
                  child:
                      Image.asset('assets/images/Slider-${widget.color}.png')),

              //Bottom content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: _buildBottomContent(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CustomText(
          widget.title,
          textAlign: TextAlign.center,
          color: widget.fontColor,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          height: 1.2,
        ),
        CustomText(
          widget.subtitle,
          textAlign: TextAlign.center,
          color: widget.fontColor,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: MaterialButton(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: widget.altColor,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CustomText(
                  'Get Started',
                  color: widget.altTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .8,
                )),
            onPressed: () => widget.onClick(),
          ),
        )
      ],
    );
  }
}
