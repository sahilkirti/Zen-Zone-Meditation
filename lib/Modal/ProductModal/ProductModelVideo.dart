import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Categories1/Video/VideoScreen.dart';

class ProductModelVideo extends StatefulWidget {
  final dynamic products;

  const ProductModelVideo({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductModelVideo> createState() => _ProductModelVideoState();
}

class _ProductModelVideoState extends State<ProductModelVideo> {
  final GlobalKey backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  spreadRadius: 0.3,
                  color: Colors.grey.shade600)
            ],
            border: Border.all(color: Colors.black, width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.circular(7)),
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieScreen(products: widget.products)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .90,
                    height: MediaQuery.of(context).size.height / 4.2,
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.products['Thumbnail'][0]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height / 28,
                  width: MediaQuery.of(context).size.width ,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                        widget.products['VideoName'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            // Row(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.fromLTRB(14, 0, 12, 12),
            //       child: Container(
            //         height: MediaQuery.of(context).size.height / 28,
            //         width: MediaQuery.of(context).size.width * .90 / 2.2,
            //         decoration: BoxDecoration(
            //             border: Border.all(width: 1, color: Colors.black),
            //             borderRadius: BorderRadius.circular(5)),
            //         child: Center(
            //           child: Text(
            //             widget.products['VideoName'],
            //             maxLines: 2,
            //             overflow: TextOverflow.ellipsis,
            //             style: GoogleFonts.abyssinicaSil(
            //               color: Colors.black,
            //               fontSize: 15,
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.fromLTRB(8, 0, 12, 12),
            //       child: InkWell(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       MovieScreen(products: widget.products)));
            //         },
            //         child: Container(
            //           height: MediaQuery.of(context).size.height / 28,
            //           width: MediaQuery.of(context).size.width * .90 / 2.1,
            //           decoration: BoxDecoration(
            //               gradient: LinearGradient(colors: [
            //                 Colors.red.shade100,
            //                 Colors.orange.shade100
            //               ]),
            //               border: Border.all(width: 1, color: Colors.black),
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Center(
            //             child: Text(
            //               'Play',
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //               style: GoogleFonts.abyssinicaSil(
            //                 color: Colors.black,
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // )
          ]),
        ),
      ),
    );
    // return Container(
    //   margin:const EdgeInsets.only(bottom:10.0,left: 8.0,right: 8.0),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(5),
    //       boxShadow: [
    //         BoxShadow(
    //             offset: Offset(2, 2),
    //             spreadRadius: 0.3,
    //             color: Colors.black,
    //         )
    //       ],
    //       border: Border.all(color: Colors.black , width: 1)
    //   ),
    //   child: AspectRatio(
    //     aspectRatio: 16/9,
    //     child: ClipRRect(
    //       borderRadius:BorderRadius.circular(5.0),
    //       child: Stack(
    //         children: [
    //           Flow(
    //             delegate: _ParallaxFlowDelegate(
    //                 scrollable: Scrollable.of(context),
    //                 listItemContext: context,
    //                 backgroundImageKey: backgroundImageKey
    //             ),
    //             children: [
    //               Image.network(
    //                 widget.products['Thumbnail'][0],
    //                 width: double.infinity,
    //                 key: backgroundImageKey,
    //                 fit: BoxFit.cover,
    //               ),
    //             ],
    //           ),
    //           Positioned.fill(
    //               child: DecoratedBox(
    //                 decoration: BoxDecoration(
    //                     gradient:LinearGradient(colors: [
    //                       Colors.transparent,
    //                       Colors.black.withOpacity(0.7),
    //                     ],
    //                         begin: Alignment.topCenter,
    //                         end: Alignment.bottomCenter,
    //                         stops:const [0.6,0.95]
    //                     )
    //                 ),
    //               )
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  _ParallaxFlowDelegate(
      {required this.scrollable,
      required this.listItemContext,
      required this.backgroundImageKey})
      : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    final verticalAlignment = Alignment(0.0, scrollFraction * 4 - 1);

    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;

    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(covariant _ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
