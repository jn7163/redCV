Red [	Title:   "Matrix tests "	Author:  "Francois Jouen"	File: 	 %FastSobel.red	Needs:	 'View]#include %../../libs/redcv.red ; for redCV functionsimg1: rcvLoadImage %../../images/lena.jpgimg2: rcvCreateImage img1/sizeimg3: rcvCreateImage img1/size rcv2Gray/average img1 img2					; Grayscaled imagercvSobel img2 img3 img1/size			; Direct Sobel on images1: rcvNamedWindow "Source"s2: rcvNamedWindow "Gray"m1: rcvNamedWindow "Direct Sobel on image"rcvMoveWindow s1 100x100rcvMoveWindow s2 400x100rcvMoveWindow m1 700x100rcvShowImage s1 img1rcvShowImage s2 img2rcvShowImage m1 img3rcvResizeWindow m1 512x512do-events