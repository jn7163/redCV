Red [	Title:   "Red Computer Vision: Core functions"	Author:  "Francois Jouen"	File: 	 %rcvCore.red	Tabs:	 4	Rights:  "Copyright (C) 2016 Francois Jouen. All rights reserved."	License: {		Distributed under the Boost Software License, Version 1.0.		See https://github.com/red/red/blob/master/BSL-License.txt	}]{To know: loaded images by red are in ARGB format (a tuple )Images are 8-bit [0..255] and internally uses bytes as a binary stringActually Red can't create 1 2 or 3 channels images : only 4 channelsActually Red can't create 16-bit (0..65536) 32-bit or 64-bit (0.0..1.0) imagespixel >>> 24				: Alphapixel and FF0000h >> 16 	: Redpixel and FF00h >> 8		: Greenpixel and FFh				: Blue}#include %rcvCoreRoutines.red		; All Red/System routines; ********* image basics **********rcvCreateImage: function [size [pair!] return: [image!]"Create empty (black) image"][	make image! reduce [size black]]rcvReleaseImage: function [src [image!]] ["Delete image from memory"	_rcvReleaseImage src]rcvLoadImage: function [fileName [file!] return: [image!] /grayscale"Loads image from file"] [	src: load fileName	if grayscale [		gray: rcvCreateImage src/size		rcv2Gray/average src gray 		_rcvCopy gray src	]	src]rcvLoadImageB: function [fileName [file!] return: [binary!] /alpha"Load image from file and return image as binary"] [	tmp: load fileName	either alpha [tmp/argb] [tmp/rgb]]rcvSaveImage: function [src [image!] fileName [file!]"Save image to file"][	write/binary file src]rcvCloneImage: function [src [image!] return: [image!]"Returns a copy of source image"] [	dst: make image! reduce [src/size black]	_rcvCopy src dst	dst]rcvCopyImage: function [src [image!] dst [image!]"Copy source image to destination image"][	_rcvCopy src dst]; OK nice but /alea very slow Must be improvedrcvRandomImage: function [size [pair!] value [tuple!] /uniform /alea return: [image!]"Create a random uniform or pixel random image"][	case [		uniform [img: make image! reduce [size random value]]		alea 	[img: make image! reduce [size black] forall img [img/1: random value ]]	] 	img]rcvZeroImage: function [src [image!]"All pixels to 0"][	src/argb: black]rcvSetAlpha: function [src [image!] dst [image!] alpha [integer!]"Sets image transparency"][	_rcvSetAlpha src dst alpha]{rcvDecodeImagercvDecodeImageMcvEncodeImage}; ********* image conversion ********** rcv2Gray: function [ src [image!]  dst [image!] /average /luminosity /lightness return: [image!]"Convert RGB image to Grayscale acording to refinement" ][	case [		average 	[_rcvConvert src dst 1]		luminosity 	[_rcvConvert src dst 111]		lightness 	[_rcvConvert src dst 112]	]]rcv2BGRA: function [src [image!] dst [image!] "Convert RGBA => BGRA"][	_rcvConvert src dst 2 ]rcv2RGBA: function [src [image!] dst [image!]"Convert BGRA => RGBA"][	_rcvConvert src dst 3 ]rcv2BW: function [src [image!] dst [image!]"Convert RGB image => Black and White" ][	_rcvConvert src dst 4]rcv2BWFilter: function [src [image!] dst [image!] thresh [integer!]"Convert RGB image => Black and White according to threshold "][	_rcvFilterBW src dst thresh]; rcvInvert: function [source [image!] dst [image!]"Similar to NOT image"][	img: copy source	dst/rgb:  complement source/rgb ]; ********** Math Operators on image **********rcvAdd: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 +  src2"][	_rcvMath src1 src2 dst 1]rcvSub: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 - src2"][	_rcvMath src1 src2 dst 2]rcvMul: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 * src2"][	_rcvMath src1 src2 dst 3]rcvDiv: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 / src2"][	_rcvMath src1 src2 dst 4] rcvMod: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 // src2 (modulo)"][	_rcvMath src1 src2 dst 5] rcvRem: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 % src2 (remainder)" ][	_rcvMath src1 src2 dst 6] rcvAbsDiff: function [src1 [image!] src2 [image!] dst [image!]"dst: absolute difference src1 src2"][	_rcvMath src1 src2 dst 7] rcvMIN: function [src1 [image!] src2 [image!] dst [image!]"dst: minimum src1 src2"] [	_rvcLogical src1 src2 dst 7]rcvMAX: function [src1 [image!] src2 [image!] dst [image!]"dst: maximum src1 src2"] [	_rvcLogical src1 src2 dst 8]; ********** Math operators with scalar (tuple or integer) *********rcvAddS: function [src [image!] dst [image!] val [integer!] "dst: src + integer! value"][	_rcvMathS src dst val 1]rcvSubS: function [src [image!] dst [image!] val [integer!]"dst: src - integer! value"][	_rcvMathS src dst val 2	]rcvMulS: function [src [image!] dst [image!] val [integer!] "dst: src * integer! value"][	_rcvMathS src dst val 3]rcvDivS: function [src [image!] dst [image!] val [integer!] "dst: src / integer! value"][	_rcvMathS src dst val 4]rcvModS: function [src [image!] dst [image!] val [integer!] "dst: src // integer! value (modulo)"][	_rcvMathS src dst val 5]rcvRemS: function [src [image!] dst [image!] val [integer!] "dst: src % integer! value (remainder)"][	_rcvMathS src dst val 6]rcvLSH: function [src [image!] dst [image!]val [integer!] "Left shift image by value"][	_rcvMathS src dst val 7]rcvRSH: function [src [image!] dst [image!] val [integer!] "Right Shift image by value"][	_rcvMathS src dst val 8]rcvPow: function [src [image!]  dst [image!] val [integer!] "dst: src ^integer! value"][	_rcvMathS src dst val 9]rcvSQR: function [src [image!] dst [image!] val [integer!]  "Image square root"][	_rcvMathS src dst val 10]rcvAddT: function [src [image!] dst [image!] val [tuple!] "dst: src + tuple! value"][	_rcvMathT src dst val 1]rcvSubT: function [src [image!] dst [image!] val [tuple!]"dst: src - tuple! value"][	_rcvMathT src dst val 2	]rcvMulT: function [src [image!] dst [image!] val [tuple!] "dst: src * tuple! value"][	_rcvMathT src dst val 3]rcvDivT: function [src [image!] dst [image!] val [tuple!] "dst: src / tuple! value"][	_rcvMathT src dst val 4]rcvModT: function [src [image!] dst [image!] val [tuple!] "dst: src // tuple! value (modulo)"][	_rcvMathT src dst val 5]rcvRemT: function [src [image!] dst [image!] val [tuple!] "dst: src % tuple! value (remainder)"][	_rcvMathT src dst val 6]; ************* Logical operator ***************************rcvAND: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 AND src2"] [	_rvcLogical src1 src2 dst 1]rcvOR: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 OR src2"] [	_rvcLogical src1 src2 dst 2]rcvXOR: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 XOR src2"] [	_rvcLogical src1 src2  dst 3]rcvNAND: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 NAND src2"] [	_rvcLogical src1 src2 dst 4]rcvNOR: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 NOR src2"] [	_rvcLogical src1 src2 dst 5]rcvNXOR: function [src1 [image!] src2 [image!] dst [image!]"dst: src1 NXOR rc2"] [	_rvcLogical src1 src2 dst 6]rcvNot: function [src [image!] dst [image!]"dst: NOT src"][	_rcvNot src dst]; ************ logical operators and scalar (tuple!) on image **********rcvANDS: function [src [image!] dst [image!] value [tuple!] "dst: src AND tuple! as image"][	tmp: make image! reduce[src/size value]	_rvcLogical src tmp dst 1	tmp: none]rcvORS: function [src [image!] dst [image!] value [tuple!] "dst: src OR tuple! as image"][	tmp: make image! reduce[src/size value]	_rvcLogical src tmp dst 2	tmp: none]rcvXORS: function [src [image!] dst [image!] value [tuple!] "dst: src XOR tuple! as image"][	tmp: make image! reduce[src/size value]	_rvcLogical src tmp dst 3	tmp: none];********** SUB-ARRAYS ************************rcvSplit: function [src [image!] dst [image!]/red /green /blue /alpha"Split source image in RGB and alpha separate channels"][	case [		red 	[_rcvChannel src dst 1]		green 	[_rcvChannel src dst 2]		blue 	[_rcvChannel src dst 3]		alpha	[_rcvChannel src dst 4]	]]rcvInRange: function [src [image!] dst [image!] lower [tuple!] upper [tuple!]"Extracts sub array from image according to lower and upper rgb values"] [	lr: lower/1 lg: lower/2 lb: lower/3	ur: upper/1 ug: upper/2 ub: upper/3	_rcvInRange src dst lr lg lb ur ug ub]