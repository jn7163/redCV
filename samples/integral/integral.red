Red [	Title:   "Integral"	Author:  "Francois Jouen"	File: 	 %integral.red	Needs:	 'View]; required last Red Master#include %../../libs/redcv.red ; for red functionsmargins: 5x5msize: 256x256img1: make image! reduce [msize black]	; srcsum: rcvCreateImage img1/size			; dst 1sqsum: rcvCreateImage img1/size			; dst 2loadImage: does [	canvas1/image: black	canvas2/image: black	canvas3/image: black	tmp: request-file	if not none? tmp [		img1: rcvLoadImage  tmp		sum: rcvCreateImage img1/size		sqsum: rcvCreateImage img1/size		rcvIntegral img1 sum sqsum img1/size		canvas1/image: img1		canvas2/image: sum		canvas3/image: sqsum	]]; ***************** Test Program ****************************view win: layout [		title "Integral Image"		origin margins space margins		button 100 "Load Image" 		[loadImage]		button 100 "Quit" 				[rcvReleaseImage img1 rcvReleaseImage sum rcvReleaseImage sqsum Quit]		return				text 256 "Source" center  text 255 "Sum" center text 255 " Square Sum" center 		return		canvas1: base msize img1		canvas2: base msize sum		canvas3: base msize sqsum]