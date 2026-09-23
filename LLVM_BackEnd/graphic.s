	.file	"graphic.ll"
	.text
	.globl	app                             ; -- Begin function app
	.type	app,@function
app:                                    ; @app
; %bb.0:                                ; %entry
	MOVhi r2 65535
	ORi r2 r2 65535
	MOVli r4 5
	PUTPIXEL r4 r4 r2
	FLUSH
	BR r0
.Lfunc_end0:
	.size	app, .Lfunc_end0-app
                                        ; -- End function
	.section	".note.GNU-stack","",@progbits
