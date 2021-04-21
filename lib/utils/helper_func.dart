import 'package:flutter/material.dart';

Future buildShowHelperDialog(BuildContext context) {
  return showGeneralDialog(
      context: context,
      barrierColor: Colors.black54.withOpacity(0.4),
      barrierDismissible: true,
      barrierLabel: "Information",
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Align(
                alignment: Alignment.topCenter.add(Alignment(0, 0.1)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh,color: Colors.white,size: 30,),
                    SizedBox(height: 12,),
                    Text(
                      "1. Pull down from this top edge to refresh forecast",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    RotatedBox(
                        quarterTurns: 3,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 30,
                        ))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.face,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Hi !",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Some important things for you to know.",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.white)),
                  ],
                ),
              ),
              Align(
                alignment: Alignment(-0.9, 0.6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RotatedBox(

                      quarterTurns: 3,
                      child: Icon(Icons.redo_rounded,size: 30,),),
                    SizedBox(height: 12,),
                    Text(
                        "2. Tap on a forecast to view more details",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white)),


                  ],
                ),
              )
            ],
          ),
        );
      });
}