	.text
	.file	"build_clang/bc.a.bc"
	.globl	task_init
	.align	2
	.type	task_init,@function
task_init:                              ; @task_init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	mov.b	#1, &full_run_started
	mov.w	#_v_func, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 0(r15)
	mov.w	#_v_n_0, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 0(r15)
	mov.w	#_v_n_1, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 0(r15)
	mov.w	#_v_n_2, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 0(r15)
	mov.w	#_v_n_3, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 0(r15)
	mov.w	#_v_n_4, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 0(r15)
	mov.w	#_v_n_5, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 0(r15)
	mov.w	#_v_n_6, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 0(r15)
	mov.b	&__task_select_func_TW__, r11
	mov.b	r11, &next_real_task_time_wgt
	mov.w	#task_select_func, &next_real_task_addr
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end0:
	.size	task_init, .Lfunc_end0-task_init

	.globl	task_select_func
	.align	2
	.type	task_select_func,@function
task_select_func:                       ; @task_select_func
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	mov.w	#_v_seed, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 2(r15)
	mov.w	#4, 0(r15)
	mov.w	#_v_iter, r15
	call	#__return_addr_wr_no_check
	mov.w	#0, 0(r15)
	mov.w	#_v_func, r15
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#0, r12
	jne	.LBB1_2
	jmp	.LBB1_1
.LBB1_1:                                ; %if.then
	mov.w	#_v_func, r15
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.b	&__task_bit_count_TW__, r11
	mov.b	r11, &next_real_task_time_wgt
	mov.w	#task_bit_count, &next_real_task_addr
	jmp	.LBB1_21
.LBB1_2:                                ; %if.else
	mov.w	#_v_func, r15
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#1, r12
	jne	.LBB1_4
	jmp	.LBB1_3
.LBB1_3:                                ; %if.then6
	mov.w	#_v_func, r15
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.b	&__task_bitcount_TW__, r11
	mov.b	r11, &next_real_task_time_wgt
	mov.w	#task_bitcount, &next_real_task_addr
	jmp	.LBB1_20
.LBB1_4:                                ; %if.else9
	mov.w	#_v_func, r15
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#2, r12
	jne	.LBB1_6
	jmp	.LBB1_5
.LBB1_5:                                ; %if.then12
	mov.w	#_v_func, r15
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.b	&__task_ntbl_bitcnt_TW__, r11
	mov.b	r11, &next_real_task_time_wgt
	mov.w	#task_ntbl_bitcnt, &next_real_task_addr
	jmp	.LBB1_19
.LBB1_6:                                ; %if.else15
	mov.w	#_v_func, r15
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#3, r12
	jne	.LBB1_8
	jmp	.LBB1_7
.LBB1_7:                                ; %if.then18
	mov.w	#_v_func, r15
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.b	&__task_ntbl_bitcount_TW__, r11
	mov.b	r11, &next_real_task_time_wgt
	mov.w	#task_ntbl_bitcount, &next_real_task_addr
	jmp	.LBB1_18
.LBB1_8:                                ; %if.else21
	mov.w	#_v_func, r15
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#4, r12
	jne	.LBB1_10
	jmp	.LBB1_9
.LBB1_9:                                ; %if.then24
	mov.w	#_v_func, r15
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.b	&__task_BW_btbl_bitcount_TW__, r11
	mov.b	r11, &next_real_task_time_wgt
	mov.w	#task_BW_btbl_bitcount, &next_real_task_addr
	jmp	.LBB1_17
.LBB1_10:                               ; %if.else27
	mov.w	#_v_func, r15
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#5, r12
	jne	.LBB1_12
	jmp	.LBB1_11
.LBB1_11:                               ; %if.then30
	mov.w	#_v_func, r15
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.b	&__task_AR_btbl_bitcount_TW__, r11
	mov.b	r11, &next_real_task_time_wgt
	mov.w	#task_AR_btbl_bitcount, &next_real_task_addr
	jmp	.LBB1_16
.LBB1_12:                               ; %if.else33
	mov.w	#_v_func, r15
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#6, r12
	jne	.LBB1_14
	jmp	.LBB1_13
.LBB1_13:                               ; %if.then36
	mov.w	#_v_func, r15
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.b	&__task_bit_shifter_TW__, r11
	mov.b	r11, &next_real_task_time_wgt
	mov.w	#task_bit_shifter, &next_real_task_addr
	jmp	.LBB1_15
.LBB1_14:                               ; %if.else39
	mov.b	&__task_end_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_end, &next_real_task_addr
	jmp	.LBB1_15
.LBB1_15:                               ; %if.end
	jmp	.LBB1_16
.LBB1_16:                               ; %if.end40
	jmp	.LBB1_17
.LBB1_17:                               ; %if.end41
	jmp	.LBB1_18
.LBB1_18:                               ; %if.end42
	jmp	.LBB1_19
.LBB1_19:                               ; %if.end43
	jmp	.LBB1_20
.LBB1_20:                               ; %if.end44
	jmp	.LBB1_21
.LBB1_21:                               ; %if.end45
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end1:
	.size	task_select_func, .Lfunc_end1-task_select_func

	.globl	task_bit_count
	.align	2
	.type	task_bit_count,@function
task_bit_count:                         ; @task_bit_count
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#16, r1
	mov.w	#_v_seed, r12
	mov.w	r12, r15
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	2(r15), r13
	mov.w	r13, -2(r4)
	mov.w	r12, -4(r4)
	add.w	#13, r12
	addc.w	#0, r13
	mov.w	-8(r4), r15             ; 2-byte Folded Reload
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	-12(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 2(r15)
	mov.w	-10(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 0(r15)
	mov.w	#0, -6(r4)
	mov.w	-2(r4), r12
	mov.w	-4(r4), r13
	bis.w	r12, r13
	cmp.w	#0, r13
	jeq	.LBB2_5
	jmp	.LBB2_1
.LBB2_1:                                ; %if.then
	jmp	.LBB2_2
.LBB2_2:                                ; %do.body
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-6(r4), r12
	add.w	#1, r12
	mov.w	r12, -6(r4)
	jmp	.LBB2_3
.LBB2_3:                                ; %do.cond
                                        ;   in Loop: Header=BB2_2 Depth=1
	mov.w	-4(r4), r12
	mov.w	-2(r4), r13
	mov.w	r12, r14
	add.w	#-1, r14
	mov.w	r13, r15
	addc.w	#-1, r15
	and.w	r14, r12
	and.w	r15, r13
	mov.w	r13, -2(r4)
	mov.w	r12, -4(r4)
	bis.w	r13, r12
	cmp.w	#0, r12
	jne	.LBB2_2
	jmp	.LBB2_4
.LBB2_4:                                ; %do.end
	jmp	.LBB2_5
.LBB2_5:                                ; %if.end
	mov.w	-6(r4), r12
	mov.w	#_v_n_0, r15
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	mov.w	-14(r4), r13            ; 2-byte Folded Reload
	add.w	r13, r12
	mov.w	r12, 0(r15)
	mov.w	#_v_iter, r12
	mov.w	r12, r15
	mov.w	r12, -16(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.w	-16(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#100, r12
	jhs	.LBB2_7
	jmp	.LBB2_6
.LBB2_6:                                ; %if.then8
	mov.b	&__task_bit_count_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_bit_count, &next_real_task_addr
	jmp	.LBB2_8
.LBB2_7:                                ; %if.else
	mov.b	&__task_select_func_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_select_func, &next_real_task_addr
	jmp	.LBB2_8
.LBB2_8:                                ; %if.end9
	add.w	#16, r1
	pop.w	r4
	ret
.Lfunc_end2:
	.size	task_bit_count, .Lfunc_end2-task_bit_count

	.globl	task_bitcount
	.align	2
	.type	task_bitcount,@function
task_bitcount:                          ; @task_bitcount
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#16, r1
	mov.w	#_v_seed, r12
	mov.w	r12, r15
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	2(r15), r13
	mov.w	r13, -2(r4)
	mov.w	r12, -4(r4)
	add.w	#13, r12
	addc.w	#0, r13
	mov.w	-6(r4), r15             ; 2-byte Folded Reload
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	mov.w	r13, -10(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	-10(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 2(r15)
	mov.w	-8(r4), r12             ; 2-byte Folded Reload
	mov.w	r12, 0(r15)
	mov.w	-4(r4), r12
	mov.w	-2(r4), r13
	mov.w	r13, r14
	and.w	#-21846, r14
	mov.w	r12, r15
	and.w	#-21846, r15
	clrc
	rrc.w	r15
	clrc
	rrc.w	r14
	and.w	#21845, r12
	and.w	#21845, r13
	add.w	r12, r15
	addc.w	r13, r14
	mov.w	r14, -2(r4)
	mov.w	r15, -4(r4)
	mov.w	r14, r12
	and.w	#-13108, r12
	mov.w	r15, r13
	and.w	#-13108, r13
	clrc
	rrc.w	r13
	rra.w	r13
	clrc
	rrc.w	r12
	rra.w	r12
	and.w	#13107, r15
	and.w	#13107, r14
	add.w	r15, r13
	addc.w	r14, r12
	mov.w	r12, -2(r4)
	mov.w	r13, -4(r4)
	mov.w	r12, r14
	and.w	#28912, r14
	mov.w	r13, r15
	and.w	#-3856, r15
	clrc
	rrc.w	r15
	rra.w	r15
	rra.w	r15
	rra.w	r15
	clrc
	rrc.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	and.w	#3855, r13
	and.w	#3855, r12
	add.w	r13, r15
	addc.w	r12, r14
	mov.w	r14, -2(r4)
	mov.w	r15, -4(r4)
	mov.w	r14, r12
	and.w	#7936, r12
	mov.w	r15, r13
	clrc
	rrc.w	r13
	rra.w	r13
	rra.w	r13
	rra.w	r13
	rra.w	r13
	rra.w	r13
	rra.w	r13
	rra.w	r13
	clrc
	rrc.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	mov.b	r15, r15
	mov.b	r14, r14
	add.w	r15, r13
	addc.w	r14, r12
	mov.w	r12, -2(r4)
	mov.w	r13, -4(r4)
	mov.w	#0, r14
	add.w	r13, r12
	addc.w	#0, r14
	mov.w	r14, -2(r4)
	mov.w	r12, -4(r4)
	mov.w	-4(r4), r12
	mov.w	#_v_n_1, r15
	mov.w	r12, -12(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	mov.w	-12(r4), r13            ; 2-byte Folded Reload
	add.w	r13, r12
	mov.w	r12, 0(r15)
	mov.w	#_v_iter, r12
	mov.w	r12, r15
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.w	-14(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#100, r12
	jhs	.LBB3_2
	jmp	.LBB3_1
.LBB3_1:                                ; %if.then
	mov.b	&__task_bitcount_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_bitcount, &next_real_task_addr
	jmp	.LBB3_3
.LBB3_2:                                ; %if.else
	mov.b	&__task_select_func_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_select_func, &next_real_task_addr
	jmp	.LBB3_3
.LBB3_3:                                ; %if.end
	add.w	#16, r1
	pop.w	r4
	ret
.Lfunc_end3:
	.size	task_bitcount, .Lfunc_end3-task_bitcount

	.globl	task_ntbl_bitcnt
	.align	2
	.type	task_ntbl_bitcnt,@function
task_ntbl_bitcnt:                       ; @task_ntbl_bitcnt
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#16, r1
	mov.w	#_v_seed, r12
	mov.w	r12, r15
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	2(r15), r13
	mov.w	r13, -2(r4)
	mov.w	r12, -4(r4)
	mov.w	r12, r14
	mov.w	r13, r15
	call	#non_recursive_cnt
	mov.w	#_v_n_2, r12
	mov.w	r15, -8(r4)             ; 2-byte Folded Spill
	mov.w	r12, r15
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	mov.w	-8(r4), r13             ; 2-byte Folded Reload
	add.w	r13, r12
	mov.w	r12, 0(r15)
	mov.w	-4(r4), r12
	mov.w	-2(r4), r14
	add.w	#13, r12
	addc.w	#0, r14
	mov.w	-6(r4), r15             ; 2-byte Folded Reload
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	mov.w	r14, -12(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	-12(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 2(r15)
	mov.w	-10(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 0(r15)
	mov.w	#_v_iter, r12
	mov.w	r12, r15
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.w	-14(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#100, r12
	jhs	.LBB4_2
	jmp	.LBB4_1
.LBB4_1:                                ; %if.then
	mov.b	&__task_ntbl_bitcnt_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_ntbl_bitcnt, &next_real_task_addr
	jmp	.LBB4_3
.LBB4_2:                                ; %if.else
	mov.b	&__task_select_func_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_select_func, &next_real_task_addr
	jmp	.LBB4_3
.LBB4_3:                                ; %if.end
	add.w	#16, r1
	pop.w	r4
	ret
.Lfunc_end4:
	.size	task_ntbl_bitcnt, .Lfunc_end4-task_ntbl_bitcnt

	.globl	non_recursive_cnt
	.align	2
	.type	non_recursive_cnt,@function
non_recursive_cnt:                      ; @non_recursive_cnt
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	;DEBUG_VALUE: non_recursive_cnt:x <- [%FP+-4]
	mov.w	r15, r12
	mov.w	r14, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	and.w	#15, r14
	mov.b	bits(r14), r14
	sxt	r14
	mov.w	r14, -6(r4)
	mov.w	r13, -8(r4)             ; 2-byte Folded Spill
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	jmp	.LBB5_1
.LBB5_1:                                ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-2(r4), r12
	mov.w	-4(r4), r13
	clrc
	rrc.w	r13
	rra.w	r13
	rra.w	r13
	rra.w	r13
	mov.w	r12, r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	bis.w	r14, r13
	clrc
	rrc.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	mov.w	r12, -2(r4)
	mov.w	r13, -4(r4)
	bis.w	r12, r13
	cmp.w	#0, r13
	jeq	.LBB5_3
	jmp	.LBB5_2
.LBB5_2:                                ; %while.body
                                        ;   in Loop: Header=BB5_1 Depth=1
	mov.w	-4(r4), r12
	and.w	#15, r12
	mov.b	bits(r12), r12
	sxt	r12
	mov.w	-6(r4), r13
	add.w	r12, r13
	mov.w	r13, -6(r4)
	jmp	.LBB5_1
.LBB5_3:                                ; %while.end
	mov.w	-6(r4), r15
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end5:
	.size	non_recursive_cnt, .Lfunc_end5-non_recursive_cnt

	.globl	task_ntbl_bitcount
	.align	2
	.type	task_ntbl_bitcount,@function
task_ntbl_bitcount:                     ; @task_ntbl_bitcount
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#20, r1
	mov.w	#_v_seed, r12
	mov.w	r12, r15
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	r12, -2(r4)
	mov.w	r12, r13
	and.w	#15, r13
	mov.b	bits(r13), r13
	sxt	r13
	mov.w	r12, r14
	and.w	#240, r14
	clrc
	rrc.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	mov.b	bits(r14), r14
	sxt	r14
	add.w	r14, r13
	mov.w	r12, r14
	and.w	#3840, r14
	clrc
	rrc.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	mov.b	bits(r14), r14
	sxt	r14
	add.w	r14, r13
	clrc
	rrc.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	mov.b	bits(r12), r12
	sxt	r12
	add.w	r12, r13
	mov.b	&bits, r12
	sxt	r12
	add.w	r12, r13
	add.w	r12, r13
	add.w	r12, r13
	add.w	r12, r13
	mov.w	#_v_n_3, r15
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	mov.w	-12(r4), r13            ; 2-byte Folded Reload
	add.w	r13, r12
	mov.w	r12, 0(r15)
	mov.w	-10(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	2(r15), r13
	mov.w	r13, -6(r4)
	mov.w	r12, -8(r4)
	add.w	#13, r12
	addc.w	#0, r13
	mov.w	-10(r4), r15            ; 2-byte Folded Reload
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	mov.w	r13, -16(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	-16(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 2(r15)
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 0(r15)
	mov.w	#_v_iter, r12
	mov.w	r12, r15
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.w	-18(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#100, r12
	jhs	.LBB6_2
	jmp	.LBB6_1
.LBB6_1:                                ; %if.then
	mov.b	&__task_ntbl_bitcount_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_ntbl_bitcount, &next_real_task_addr
	jmp	.LBB6_3
.LBB6_2:                                ; %if.else
	mov.b	&__task_select_func_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_select_func, &next_real_task_addr
	jmp	.LBB6_3
.LBB6_3:                                ; %if.end
	add.w	#20, r1
	pop.w	r4
	ret
.Lfunc_end6:
	.size	task_ntbl_bitcount, .Lfunc_end6-task_ntbl_bitcount

	.globl	task_BW_btbl_bitcount
	.align	2
	.type	task_BW_btbl_bitcount,@function
task_BW_btbl_bitcount:                  ; @task_BW_btbl_bitcount
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#20, r1
	mov.w	#_v_seed, r12
	mov.w	r12, r15
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	2(r15), r13
	mov.w	r13, -2(r4)
	mov.w	r12, -4(r4)
	mov.b	-4(r4), r12
	mov.b	bits(r12), r12
	sxt	r12
	mov.b	-3(r4), r13
	mov.b	bits(r13), r13
	sxt	r13
	add.w	r13, r12
	mov.b	-1(r4), r13
	mov.b	bits(r13), r13
	sxt	r13
	add.w	r13, r12
	mov.b	-2(r4), r13
	mov.b	bits(r13), r13
	sxt	r13
	add.w	r13, r12
	mov.w	#_v_n_4, r15
	mov.w	r12, -12(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	mov.w	-12(r4), r13            ; 2-byte Folded Reload
	add.w	r13, r12
	mov.w	r12, 0(r15)
	mov.w	-10(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	2(r15), r13
	mov.w	r13, -6(r4)
	mov.w	r12, -8(r4)
	add.w	#13, r12
	addc.w	#0, r13
	mov.w	-10(r4), r15            ; 2-byte Folded Reload
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	mov.w	r13, -16(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	-16(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 2(r15)
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 0(r15)
	mov.w	#_v_iter, r12
	mov.w	r12, r15
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.w	-18(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#100, r12
	jhs	.LBB7_2
	jmp	.LBB7_1
.LBB7_1:                                ; %if.then
	mov.b	&__task_BW_btbl_bitcount_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_BW_btbl_bitcount, &next_real_task_addr
	jmp	.LBB7_3
.LBB7_2:                                ; %if.else
	mov.b	&__task_select_func_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_select_func, &next_real_task_addr
	jmp	.LBB7_3
.LBB7_3:                                ; %if.end
	add.w	#20, r1
	pop.w	r4
	ret
.Lfunc_end7:
	.size	task_BW_btbl_bitcount, .Lfunc_end7-task_BW_btbl_bitcount

	.globl	task_AR_btbl_bitcount
	.align	2
	.type	task_AR_btbl_bitcount,@function
task_AR_btbl_bitcount:                  ; @task_AR_btbl_bitcount
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#20, r1
	mov.w	#_v_seed, r12
	mov.w	r12, r15
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#__return_addr_no_check
	mov.w	r15, -2(r4)
	mov.w	r15, r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	mov.b	0(r15), r12
	mov.b	bits(r12), r12
	sxt	r12
	mov.w	r12, -4(r4)
	mov.w	-2(r4), r12
	mov.w	r12, r13
	add.w	#1, r13
	mov.w	r13, -2(r4)
	mov.b	0(r12), r12
	mov.b	bits(r12), r12
	sxt	r12
	mov.w	-4(r4), r13
	add.w	r12, r13
	mov.w	r13, -4(r4)
	mov.w	-2(r4), r12
	mov.w	r12, r13
	add.w	#1, r13
	mov.w	r13, -2(r4)
	mov.b	0(r12), r12
	mov.b	bits(r12), r12
	sxt	r12
	mov.w	-4(r4), r13
	add.w	r12, r13
	mov.w	r13, -4(r4)
	mov.w	-2(r4), r12
	mov.b	0(r12), r12
	mov.b	bits(r12), r12
	sxt	r12
	add.w	r12, r13
	mov.w	r13, -4(r4)
	mov.w	#_v_n_5, r15
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	mov.w	-12(r4), r13            ; 2-byte Folded Reload
	add.w	r13, r12
	mov.w	r12, 0(r15)
	mov.w	-10(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	2(r15), r13
	mov.w	r13, -6(r4)
	mov.w	r12, -8(r4)
	add.w	#13, r12
	addc.w	#0, r13
	mov.w	-10(r4), r15            ; 2-byte Folded Reload
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	mov.w	r13, -16(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	-16(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 2(r15)
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 0(r15)
	mov.w	#_v_iter, r12
	mov.w	r12, r15
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.w	-18(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#100, r12
	jhs	.LBB8_2
	jmp	.LBB8_1
.LBB8_1:                                ; %if.then
	mov.b	&__task_AR_btbl_bitcount_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_AR_btbl_bitcount, &next_real_task_addr
	jmp	.LBB8_3
.LBB8_2:                                ; %if.else
	mov.b	&__task_select_func_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_select_func, &next_real_task_addr
	jmp	.LBB8_3
.LBB8_3:                                ; %if.end
	add.w	#20, r1
	pop.w	r4
	ret
.Lfunc_end8:
	.size	task_AR_btbl_bitcount, .Lfunc_end8-task_AR_btbl_bitcount

	.globl	task_bit_shifter
	.align	2
	.type	task_bit_shifter,@function
task_bit_shifter:                       ; @task_bit_shifter
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#20, r1
	mov.w	#_v_seed, r15
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	2(r15), r13
	mov.w	r13, -6(r4)
	mov.w	r12, -8(r4)
	mov.w	#0, -4(r4)
	mov.w	#0, -2(r4)
	jmp	.LBB9_1
.LBB9_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-6(r4), r12
	mov.w	-8(r4), r13
	mov.b	#0, r14
	bis.w	r12, r13
	cmp.w	#0, r13
	mov.b	r14, -9(r4)             ; 1-byte Folded Spill
	jeq	.LBB9_3
	jmp	.LBB9_2
.LBB9_2:                                ; %land.rhs
                                        ;   in Loop: Header=BB9_1 Depth=1
	mov.w	-2(r4), r12
	cmp.w	#32, r12
	mov.w	r2, r12
	mov.w	#1, r13
	bic.w	r12, r13
	mov.b	r13, r14
	mov.b	r14, -9(r4)             ; 1-byte Folded Spill
	jmp	.LBB9_3
.LBB9_3:                                ; %land.end
                                        ;   in Loop: Header=BB9_1 Depth=1
	mov.b	-9(r4), r12             ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB9_6
	jmp	.LBB9_4
.LBB9_4:                                ; %for.body
                                        ;   in Loop: Header=BB9_1 Depth=1
	mov.w	-8(r4), r12
	and.w	#1, r12
	mov.w	-4(r4), r13
	add.w	r12, r13
	mov.w	r13, -4(r4)
	jmp	.LBB9_5
.LBB9_5:                                ; %for.inc
                                        ;   in Loop: Header=BB9_1 Depth=1
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	mov.w	-6(r4), r12
	mov.w	-8(r4), r13
	clrc
	rrc.w	r13
	mov.w	r12, r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	bis.w	r14, r13
	clrc
	rrc.w	r12
	mov.w	r12, -6(r4)
	mov.w	r13, -8(r4)
	jmp	.LBB9_1
.LBB9_6:                                ; %for.end
	mov.w	-4(r4), r12
	mov.w	#_v_n_6, r15
	mov.w	r12, -12(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	mov.w	-12(r4), r13            ; 2-byte Folded Reload
	add.w	r13, r12
	mov.w	r12, 0(r15)
	mov.w	#_v_seed, r12
	mov.w	r12, r15
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	mov.w	2(r15), r13
	mov.w	r13, -6(r4)
	mov.w	r12, -8(r4)
	add.w	#13, r12
	addc.w	#0, r13
	mov.w	r13, -6(r4)
	mov.w	r12, -8(r4)
	mov.w	-14(r4), r15            ; 2-byte Folded Reload
	mov.w	r12, -16(r4)            ; 2-byte Folded Spill
	mov.w	r13, -18(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	-18(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, 2(r15)
	mov.w	-16(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 0(r15)
	mov.w	#_v_iter, r14
	mov.w	r14, r15
	mov.w	r14, -20(r4)            ; 2-byte Folded Spill
	call	#__return_addr_wr_no_check
	mov.w	0(r15), r12
	add.w	#1, r12
	mov.w	r12, 0(r15)
	mov.w	-20(r4), r15            ; 2-byte Folded Reload
	call	#__return_addr_no_check
	mov.w	0(r15), r12
	cmp.w	#100, r12
	jhs	.LBB9_8
	jmp	.LBB9_7
.LBB9_7:                                ; %if.then
	mov.b	&__task_bit_shifter_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_bit_shifter, &next_real_task_addr
	jmp	.LBB9_9
.LBB9_8:                                ; %if.else
	mov.b	&__task_select_func_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_select_func, &next_real_task_addr
	jmp	.LBB9_9
.LBB9_9:                                ; %if.end
	add.w	#20, r1
	pop.w	r4
	ret
.Lfunc_end9:
	.size	task_bit_shifter, .Lfunc_end9-task_bit_shifter

	.globl	task_end
	.align	2
	.type	task_end,@function
task_end:                               ; @task_end
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	&full_run_started, r12
	cmp.b	#0, r12
	jeq	.LBB10_2
	jmp	.LBB10_1
.LBB10_1:                               ; %if.then
	mov.w	&TA0CTL, r12
	and.w	#-17, r12
	mov.w	r12, &TA0CTL
	mov.b	&PAOUT_H, r12
	bis.w	#4, r12
	mov.b	r12, r13
	mov.b	r13, &PAOUT_H
	mov.b	&PAOUT_H, r12
	and.w	#251, r12
	mov.b	r12, r13
	mov.b	r13, &PAOUT_H
	mov.b	#0, &full_run_started
	call	#__coala_force_commit
	mov.w	&TA0CTL, r12
	bis.w	#16, r12
	mov.w	r12, &TA0CTL
	jmp	.LBB10_2
.LBB10_2:                               ; %if.end
	mov.b	&__task_init_TW__, r12
	mov.b	r12, &next_real_task_time_wgt
	mov.w	#task_init, &next_real_task_addr
	pop.w	r4
	ret
.Lfunc_end10:
	.size	task_end, .Lfunc_end10-task_end

	.globl	recursive_cnt
	.align	2
	.type	recursive_cnt,@function
recursive_cnt:                          ; @recursive_cnt
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#14, r1
	;DEBUG_VALUE: recursive_cnt:x <- [%FP+-6]
	mov.w	r15, r12
	mov.w	r14, r13
	mov.w	r15, -6(r4)
	mov.w	r14, -8(r4)
	and.w	#15, r14
	mov.b	bits(r14), r14
	sxt	r14
	mov.w	r14, -10(r4)
	mov.w	-6(r4), r14
	mov.w	-8(r4), r15
	clrc
	rrc.w	r15
	rra.w	r15
	rra.w	r15
	rra.w	r15
	mov.w	r14, r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	rla.w	r11
	bis.w	r11, r15
	clrc
	rrc.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	mov.w	r14, -6(r4)
	mov.w	r15, -8(r4)
	bis.w	r14, r15
	cmp.w	#0, r15
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	jeq	.LBB11_2
	jmp	.LBB11_1
.LBB11_1:                               ; %if.then
	;DEBUG_VALUE: recursive_cnt:x <- [%FP+-6]
	mov.w	-6(r4), r15
	mov.w	-8(r4), r14
	call	#recursive_cnt
	mov.w	-10(r4), r12
	add.w	r15, r12
	mov.w	r12, -10(r4)
	jmp	.LBB11_2
.LBB11_2:                               ; %if.end
	;DEBUG_VALUE: recursive_cnt:x <- [%FP+-6]
	mov.w	-10(r4), r15
	add.w	#14, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end11:
	.size	recursive_cnt, .Lfunc_end11-recursive_cnt

	.globl	init
	.align	2
	.type	init,@function
init:                                   ; @init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#23168, &WDTCTL
	mov.w	&PM5CTL0, r12
	and.w	#-2, r12
	mov.w	r12, &PM5CTL0
	mov.b	&PAOUT_H, r12
	and.w	#251, r12
	mov.b	r12, r13
	mov.b	r13, &PAOUT_H
	mov.b	&PBOUT_L, r12
	and.w	#239, r12
	mov.b	r12, r13
	mov.b	r13, &PBOUT_L
	mov.b	&PBOUT_L, r12
	and.w	#223, r12
	mov.b	r12, r13
	mov.b	r13, &PBOUT_L
	mov.b	&PBOUT_L, r12
	and.w	#191, r12
	mov.b	r12, r13
	mov.b	r13, &PBOUT_L
	mov.b	&PADIR_H, r12
	bis.w	#4, r12
	mov.b	r12, r13
	mov.b	r13, &PADIR_H
	mov.b	&PBDIR_L, r12
	bis.w	#16, r12
	mov.b	r12, r13
	mov.b	r13, &PBDIR_L
	mov.b	&PBDIR_L, r12
	bis.w	#32, r12
	mov.b	r12, r13
	mov.b	r13, &PBDIR_L
	mov.b	&PBDIR_L, r12
	bis.w	#64, r12
	mov.b	r12, r13
	mov.b	r13, &PBDIR_L
	mov.b	&PBOUT_L, r12
	bis.w	#16, r12
	mov.b	r12, r13
	mov.b	r13, &PBOUT_L
	mov.w	#-15536, r15
	call	#msp_reseter_auto_rand
	pop.w	r4
	ret
.Lfunc_end12:
	.size	init, .Lfunc_end12-init

	.globl	main
	.align	2
	.type	main,@function
main:                                   ; @main
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#2, r1
	mov.w	#0, -4(r4)
	call	#init
	mov.b	&__task_init_TW__, r14
	mov.w	#task_init, r15
	call	#__coala_init
	mov.b	&first_run, r11
	cmp.b	#0, r11
	jeq	.LBB13_2
	jmp	.LBB13_1
.LBB13_1:                               ; %if.then
	mov.b	&PAOUT_H, r12
	bis.w	#4, r12
	mov.b	r12, r13
	mov.b	r13, &PAOUT_H
	mov.b	&PAOUT_H, r12
	and.w	#251, r12
	mov.b	r12, r13
	mov.b	r13, &PAOUT_H
	mov.b	#0, &first_run
	jmp	.LBB13_2
.LBB13_2:                               ; %if.end
	call	#__coala_run
	mov.w	#0, r15
	add.w	#2, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end13:
	.size	main, .Lfunc_end13-main

	.globl	Timer0_B0_ISR
	.align	2
	.type	Timer0_B0_ISR,@function
Timer0_B0_ISR:                          ; @Timer0_B0_ISR
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r15
	push.w	r14
	push.w	r13
	push.w	r12
	sub.w	#2, r1
	call	#__commit_partial_execution
	mov.b	#0, &death_count
	mov.w	&pe_ccr, r12
	clrc
	rrc.w	r12
	mov.w	r12, -10(r4)
	mov.w	&pe_ccr, r13
	xor.w	#-1, r13
	cmp.w	r12, r13
	jhs	.LBB14_2
	jmp	.LBB14_1
.LBB14_1:                               ; %if.then
	mov.w	#-1, &pe_ccr
	jmp	.LBB14_3
.LBB14_2:                               ; %if.else
	mov.w	-10(r4), r12
	mov.w	&pe_ccr, r13
	add.w	r12, r13
	mov.w	r13, &pe_ccr
	jmp	.LBB14_3
.LBB14_3:                               ; %if.end
	mov.w	&pe_ccr, r12
	mov.w	r12, &succ_pe_ccr
	add.w	#2, r1
	pop.w	r12
	pop.w	r13
	pop.w	r14
	pop.w	r15
	pop.w	r4
	reti
.Lfunc_end14:
	.size	Timer0_B0_ISR, .Lfunc_end14-Timer0_B0_ISR

	.globl	__commit_partial_execution
	.align	2
	.type	__commit_partial_execution,@function
__commit_partial_execution:             ; @__commit_partial_execution
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#16, r1
	mov.w	#0, -4(r4)
	jmp	.LBB15_1
.LBB15_1:                               ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-4(r4), r12
	mov.b	#0, r13
	cmp.w	#32, r12
	mov.b	r13, -11(r4)            ; 1-byte Folded Spill
	jhs	.LBB15_3
	jmp	.LBB15_2
.LBB15_2:                               ; %land.rhs
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-4(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf+4(r15), r12
	cmp.w	#0, r12
	mov.w	r2, r12
	rra.w	r12
	mov.w	#1, r13
	bic.w	r12, r13
	mov.b	r13, r11
	mov.b	r11, -11(r4)            ; 1-byte Folded Spill
	jmp	.LBB15_3
.LBB15_3:                               ; %land.end
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.b	-11(r4), r12            ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB15_8
	jmp	.LBB15_4
.LBB15_4:                               ; %for.body
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-4(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.b	ram_pages_buf+2(r15), r11
	cmp.b	#0, r11
	jeq	.LBB15_6
	jmp	.LBB15_5
.LBB15_5:                               ; %if.then
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-4(r4), r15
	mov.w	#6, r12
	mov.w	r12, r14
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf(r15), r12
	mov.w	ram_pages_buf+4(r15), r14
	mov.w	r12, r15
	call	#__copy_page_to_shadow_buf
	mov.w	-4(r4), r15
	mov.w	-14(r4), r14            ; 2-byte Folded Reload
	call	#__mulhi3hw_noint
	mov.b	#0, ram_pages_buf+2(r15)
	jmp	.LBB15_6
.LBB15_6:                               ; %if.end
                                        ;   in Loop: Header=BB15_1 Depth=1
	jmp	.LBB15_7
.LBB15_7:                               ; %for.inc
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-4(r4), r12
	add.w	#1, r12
	mov.w	r12, -4(r4)
	jmp	.LBB15_1
.LBB15_8:                               ; %for.end
	;APP
	PUSH R0
	;NO_APP
	;APP
	NOP
	;NO_APP
	mov.b	&restoring, r12
	cmp.b	#1, r12
	jeq	.LBB15_10
	jmp	.LBB15_9
.LBB15_9:                               ; %if.then10
	;APP
	PUSH R2
	;NO_APP
	;APP
	PUSH R4
	;NO_APP
	;APP
	PUSH R5
	;NO_APP
	;APP
	PUSH R6
	;NO_APP
	;APP
	PUSH R7
	;NO_APP
	;APP
	PUSH R8
	;NO_APP
	;APP
	PUSH R9
	;NO_APP
	;APP
	PUSH R10
	;NO_APP
	;APP
	PUSH R11
	;NO_APP
	;APP
	PUSH R12
	;NO_APP
	;APP
	PUSH R13
	;NO_APP
	;APP
	PUSH R14
	;NO_APP
	;APP
	PUSH R15
	;NO_APP
	;APP
	MOV R1, stack_ptr 
	;NO_APP
	;APP
	ADD #0x1C, R1
	;NO_APP
	jmp	.LBB15_10
.LBB15_10:                              ; %if.end11
	mov.b	&restoring, r12
	cmp.b	#1, r12
	jeq	.LBB15_14
	jmp	.LBB15_11
.LBB15_11:                              ; %if.then15
	;DEBUG_VALUE: src <- [%FP+-4]
	;DEBUG_VALUE: dst <- [%FP+-6]
	;DEBUG_VALUE: len <- [%FP+-8]
	mov.w	&stack_ptr, r12
	mov.w	r12, -6(r4)
	mov.w	&last_cp_buf, r12
	mov.w	#-17664, r13
	mov.w	#-18688, r14
	cmp.w	#-17664, r12
	mov.w	r13, -16(r4)            ; 2-byte Folded Spill
	mov.w	r14, -18(r4)            ; 2-byte Folded Spill
	jeq	.LBB15_13
; BB#12:                                ; %if.then15
	;DEBUG_VALUE: len <- [%FP+-8]
	;DEBUG_VALUE: dst <- [%FP+-6]
	;DEBUG_VALUE: src <- [%FP+-4]
	mov.w	-16(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
.LBB15_13:                              ; %if.then15
	;DEBUG_VALUE: len <- [%FP+-8]
	;DEBUG_VALUE: dst <- [%FP+-6]
	;DEBUG_VALUE: src <- [%FP+-4]
	mov.w	-18(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -8(r4)
	mov.w	&stack_ptr, r12
	mov.w	#9216, r13
	sub.w	r12, r13
	mov.w	r13, -10(r4)
	mov.w	-6(r4), r12
	mov.w	r12, &DMA0SAL
	mov.w	-8(r4), r12
	mov.w	r12, &DMA0DAL
	mov.w	-10(r4), r12
	clrc
	rrc.w	r12
	mov.w	r12, &DMA0SZ
	mov.w	#7936, &DMA0CTL
	mov.w	&DMA0CTL, r12
	bis.w	#17, r12
	mov.w	r12, &DMA0CTL
	mov.w	-8(r4), r12
	mov.w	r12, &last_cp_buf
	jmp	.LBB15_15
.LBB15_14:                              ; %if.else
	mov.b	#0, &restoring
	jmp	.LBB15_15
.LBB15_15:                              ; %if.end18
	mov.b	#1, &checkpoint_available
	mov.b	#1, &commit_flag
	call	#__commit_to_store_buf
	mov.b	#0, &commit_flag
	add.w	#16, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end15:
	.size	__commit_partial_execution, .Lfunc_end15-__commit_partial_execution

	.globl	__copy_page_to_shadow_buf
	.align	2
	.type	__copy_page_to_shadow_buf,@function
__copy_page_to_shadow_buf:              ; @__copy_page_to_shadow_buf
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#16, r1
	;DEBUG_VALUE: __copy_page_to_shadow_buf:src_page <- [%FP+-6]
	;DEBUG_VALUE: __copy_page_to_shadow_buf:dst_page <- [%FP+-8]
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -8(r4)
	mov.w	r14, -10(r4)
	add.w	#16640, r14
	clrc
	rrc.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	mov.w	r14, -12(r4)
	mov.b	store_buf(r14), r11
	cmp.b	#0, r11
	mov.w	r12, -16(r4)            ; 2-byte Folded Spill
	mov.w	r13, -18(r4)            ; 2-byte Folded Spill
	jne	.LBB16_2
	jmp	.LBB16_1
.LBB16_1:                               ; %if.then
	;DEBUG_VALUE: __copy_page_to_shadow_buf:dst_page <- [%FP+-8]
	;DEBUG_VALUE: __copy_page_to_shadow_buf:src_page <- [%FP+-6]
	mov.w	-10(r4), r12
	add.w	#8192, r12
	mov.w	r12, -10(r4)
	jmp	.LBB16_2
.LBB16_2:                               ; %if.end
	;DEBUG_VALUE: __copy_page_to_shadow_buf:dst_page <- [%FP+-8]
	;DEBUG_VALUE: __copy_page_to_shadow_buf:src_page <- [%FP+-6]
	mov.w	-8(r4), r12
	mov.w	-10(r4), r13
	mov.w	r12, -4(r4)
	mov.w	r13, -6(r4)
	mov.w	-4(r4), r12
	mov.w	r12, &DMA1SAL
	mov.w	-6(r4), r12
	mov.w	r12, &DMA1DAL
	mov.w	&DMA1CTL, r12
	bis.w	#17, r12
	mov.w	r12, &DMA1CTL
	;DEBUG_VALUE: __copy_page_to_shadow_buf:i <- [%FP+-12]
	mov.w	#0, -14(r4)
	jmp	.LBB16_3
.LBB16_3:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-14(r4), r12
	mov.w	&shadow_buf_pages_count, r13
	cmp.w	r13, r12
	jhs	.LBB16_7
	jmp	.LBB16_4
.LBB16_4:                               ; %while.body
                                        ;   in Loop: Header=BB16_3 Depth=1
	mov.w	-14(r4), r12
	mov.b	shadow_buf_pages(r12), r12
	mov.w	-12(r4), r13
	cmp.w	r13, r12
	jne	.LBB16_6
	jmp	.LBB16_5
.LBB16_5:                               ; %if.then4
	jmp	.LBB16_8
.LBB16_6:                               ; %if.end5
                                        ;   in Loop: Header=BB16_3 Depth=1
	mov.w	-14(r4), r12
	add.w	#1, r12
	mov.w	r12, -14(r4)
	jmp	.LBB16_3
.LBB16_7:                               ; %while.end
	mov.w	&shadow_buf_pages_count, r12
	add.w	#1, r12
	mov.w	r12, &shadow_buf_pages_count
	mov.b	-12(r4), r13
	mov.w	-14(r4), r12
	mov.b	r13, shadow_buf_pages(r12)
	jmp	.LBB16_8
.LBB16_8:                               ; %return
	add.w	#16, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end16:
	.size	__copy_page_to_shadow_buf, .Lfunc_end16-__copy_page_to_shadow_buf

	.globl	__commit_to_store_buf
	.align	2
	.type	__commit_to_store_buf,@function
__commit_to_store_buf:                  ; @__commit_to_store_buf
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	mov.w	&commit_page_idx, r12
	mov.w	r12, -2(r4)
	jmp	.LBB17_1
.LBB17_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-2(r4), r12
	mov.w	&shadow_buf_pages_count, r13
	cmp.w	r13, r12
	jhs	.LBB17_5
	jmp	.LBB17_2
.LBB17_2:                               ; %while.body
                                        ;   in Loop: Header=BB17_1 Depth=1
	mov.w	-2(r4), r12
	mov.b	shadow_buf_pages(r12), r12
	mov.b	store_buf(r12), r12
	bit.w	#16, r12
	jne	.LBB17_4
	jmp	.LBB17_3
.LBB17_3:                               ; %if.then
                                        ;   in Loop: Header=BB17_1 Depth=1
	mov.w	-2(r4), r12
	mov.b	shadow_buf_pages(r12), r12
	mov.b	store_buf(r12), r13
	xor.w	#17, r13
	mov.b	r13, r14
	mov.b	r14, store_buf(r12)
	jmp	.LBB17_4
.LBB17_4:                               ; %if.end
                                        ;   in Loop: Header=BB17_1 Depth=1
	;APP
	ADD.W	#1, &commit_page_idx

	;NO_APP
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB17_1
.LBB17_5:                               ; %while.end
	jmp	.LBB17_6
.LBB17_6:                               ; %while.cond7
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-2(r4), r12
	cmp.w	#0, r12
	jeq	.LBB17_8
	jmp	.LBB17_7
.LBB17_7:                               ; %while.body9
                                        ;   in Loop: Header=BB17_6 Depth=1
	mov.w	-2(r4), r12
	mov.b	shadow_buf_pages-1(r12), r12
	mov.b	store_buf(r12), r13
	and.w	#239, r13
	mov.b	r13, r14
	mov.b	r14, store_buf(r12)
	mov.w	-2(r4), r12
	add.w	#-1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB17_6
.LBB17_8:                               ; %while.end16
	mov.w	#0, &shadow_buf_pages_count
	mov.w	#0, &commit_page_idx
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end17:
	.size	__commit_to_store_buf, .Lfunc_end17-__commit_to_store_buf

	.globl	__coala_init
	.align	2
	.type	__coala_init,@function
__coala_init:                           ; @__coala_init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#6, r1
	;DEBUG_VALUE: __coala_init:origin_task_pt <- [%FP+-2]
	;DEBUG_VALUE: __coala_init:origin_task_time_wgt <- [%FP+-3]
	mov.b	r14, r12
	mov.w	r15, r14
	mov.w	r15, -4(r4)
	mov.b	r12, -5(r4)
	mov.w	r14, -8(r4)             ; 2-byte Folded Spill
	call	#__dma_init
	mov.b	&init_done, r11
	cmp.b	#-83, r11
	jeq	.LBB18_2
	jmp	.LBB18_1
.LBB18_1:                               ; %if.then
	;DEBUG_VALUE: __coala_init:origin_task_time_wgt <- [%FP+-3]
	;DEBUG_VALUE: __coala_init:origin_task_pt <- [%FP+-2]
	mov.w	-4(r4), r12
	mov.w	r12, &coalesced_task_addr
	mov.b	-5(r4), r13
	mov.b	r13, &coalesced_task_time_wgt
	mov.b	#-83, &init_done
	jmp	.LBB18_2
.LBB18_2:                               ; %if.end
	;DEBUG_VALUE: __coala_init:origin_task_time_wgt <- [%FP+-3]
	;DEBUG_VALUE: __coala_init:origin_task_pt <- [%FP+-2]
	add.w	#6, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end18:
	.size	__coala_init, .Lfunc_end18-__coala_init

	.globl	__dma_init
	.align	2
	.type	__dma_init,@function
__dma_init:                             ; @__dma_init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#16, &DMA1SZ
	mov.w	#7936, &DMA1CTL
	pop.w	r4
	ret
.Lfunc_end19:
	.size	__dma_init, .Lfunc_end19-__dma_init

	.globl	__coala_run
	.align	2
	.type	__coala_run,@function
__coala_run:                            ; @__coala_run
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	call	#__scheduler
	pop.w	r4
	ret
.Lfunc_end20:
	.size	__coala_run, .Lfunc_end20-__coala_run

	.globl	__scheduler
	.align	2
	.type	__scheduler,@function
__scheduler:                            ; @__scheduler
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#16, r1
	mov.w	&history, r12
	clrc
	rrc.w	r12
	add.w	#1, r12
	mov.w	r12, &target_budget
	mov.w	&history, r12
	mov.w	r12, &previous_history
	mov.w	#0, &history
	mov.b	&commit_flag, r13
	cmp.b	#1, r13
	jne	.LBB21_2
	jmp	.LBB21_1
.LBB21_1:                               ; %if.then
	call	#__reset_partial_execution
	mov.w	&next_coalesced_task_addr, r12
	mov.w	r12, &coalesced_task_addr
	call	#__commit_to_store_buf
	mov.b	#0, &commit_flag
	jmp	.LBB21_2
.LBB21_2:                               ; %if.end
	mov.w	#0, &shadow_buf_pages_count
	mov.w	#7168, -8(r4)
	mov.w	#0, -6(r4)
	jmp	.LBB21_3
.LBB21_3:                               ; %for.cond.i
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-6(r4), r12
	cmp.w	#32, r12
	jhs	.LBB21_5
	jmp	.LBB21_4
.LBB21_4:                               ; %for.body.i
                                        ;   in Loop: Header=BB21_3 Depth=1
	mov.w	-8(r4), r12
	mov.w	-6(r4), r15
	mov.w	#6, r14
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, ram_pages_buf(r15)
	mov.w	-8(r4), r12
	add.w	#32, r12
	mov.w	r12, -8(r4)
	mov.w	-6(r4), r12
	add.w	#1, r12
	mov.w	r12, -6(r4)
	jmp	.LBB21_3
.LBB21_5:                               ; %initialize_sram_buffer.exit
	mov.w	&coalesced_task_addr, r12
	mov.w	r12, &real_task_addr
	mov.b	&checkpoint_available, r13
	cmp.b	#0, r13
	jeq	.LBB21_7
	jmp	.LBB21_6
.LBB21_6:                               ; %if.then2
	;DEBUG_VALUE: dst <- [%FP+-8]
	;DEBUG_VALUE: len <- [%FP+-10]
	mov.w	&stack_ptr, r12
	mov.w	r12, -10(r4)
	mov.w	&stack_ptr, r12
	mov.w	#9216, r13
	sub.w	r12, r13
	mov.w	r13, -12(r4)
	mov.w	&last_cp_buf, r12
	mov.w	r12, &DMA0SAL
	mov.w	-10(r4), r12
	mov.w	r12, &DMA0DAL
	mov.w	-12(r4), r12
	clrc
	rrc.w	r12
	mov.w	r12, &DMA0SZ
	mov.w	#7936, &DMA0CTL
	mov.w	&DMA0CTL, r12
	bis.w	#17, r12
	mov.w	r12, &DMA0CTL
	;APP
	MOV stack_ptr, R1
	;NO_APP
	;APP
	POP R15
	;NO_APP
	;APP
	POP R14
	;NO_APP
	;APP
	POP R13
	;NO_APP
	;APP
	POP R12
	;NO_APP
	;APP
	POP R11
	;NO_APP
	;APP
	POP R10
	;NO_APP
	;APP
	POP R9
	;NO_APP
	;APP
	POP R8
	;NO_APP
	;APP
	POP R7
	;NO_APP
	;APP
	POP R6
	;NO_APP
	;APP
	POP R5
	;NO_APP
	;APP
	POP R4
	;NO_APP
	;APP
	POP R2
	;NO_APP
	;APP
	MOV #0x01, &restoring
	;NO_APP
	;APP
	POP R0
	;NO_APP
	jmp	.LBB21_7
.LBB21_7:                               ; %if.end3
	jmp	.LBB21_8
.LBB21_8:                               ; %while.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB21_9 Depth 2
                                        ;     Child Loop BB21_12 Depth 2
	mov.b	#0, &checkpoint_available
	mov.w	#0, &current_budget
	jmp	.LBB21_9
.LBB21_9:                               ; %while.cond4
                                        ;   Parent Loop BB21_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov.w	&current_budget, r12
	mov.w	&target_budget, r13
	cmp.w	r13, r12
	jhs	.LBB21_11
	jmp	.LBB21_10
.LBB21_10:                              ; %while.body7
                                        ;   in Loop: Header=BB21_9 Depth=2
	mov.w	&real_task_addr, r12
	call	r12
	mov.w	&next_real_task_addr, r12
	mov.w	r12, &real_task_addr
	mov.w	&current_budget, r12
	add.w	#1, r12
	mov.w	r12, &current_budget
	mov.w	&history, r12
	add.w	#1, r12
	mov.w	r12, &history
	jmp	.LBB21_9
.LBB21_11:                              ; %while.end
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.w	&real_task_addr, r12
	mov.w	r12, &next_coalesced_task_addr
	mov.w	#0, -4(r4)
	jmp	.LBB21_12
.LBB21_12:                              ; %for.cond.i13
                                        ;   Parent Loop BB21_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov.w	-4(r4), r12
	mov.b	#0, r13
	cmp.w	#32, r12
	mov.b	r13, -15(r4)            ; 1-byte Folded Spill
	jhs	.LBB21_14
	jmp	.LBB21_13
.LBB21_13:                              ; %land.rhs.i
                                        ;   in Loop: Header=BB21_12 Depth=2
	mov.w	-4(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf+4(r15), r12
	cmp.w	#0, r12
	mov.w	r2, r12
	rra.w	r12
	mov.w	#1, r13
	bic.w	r12, r13
	mov.b	r13, r11
	mov.b	r11, -15(r4)            ; 1-byte Folded Spill
	jmp	.LBB21_14
.LBB21_14:                              ; %land.end.i
                                        ;   in Loop: Header=BB21_12 Depth=2
	mov.b	-15(r4), r12            ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB21_18
	jmp	.LBB21_15
.LBB21_15:                              ; %for.body.i16
                                        ;   in Loop: Header=BB21_12 Depth=2
	mov.w	-4(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.b	ram_pages_buf+2(r15), r11
	cmp.b	#0, r11
	jeq	.LBB21_17
	jmp	.LBB21_16
.LBB21_16:                              ; %if.then.i18
                                        ;   in Loop: Header=BB21_12 Depth=2
	mov.w	-4(r4), r15
	mov.w	#6, r12
	mov.w	r12, r14
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf(r15), r12
	mov.w	ram_pages_buf+4(r15), r14
	mov.w	r12, r15
	call	#__copy_page_to_shadow_buf
	mov.w	-4(r4), r15
	mov.w	-18(r4), r14            ; 2-byte Folded Reload
	call	#__mulhi3hw_noint
	mov.b	#0, ram_pages_buf+2(r15)
	jmp	.LBB21_17
.LBB21_17:                              ; %if.end.i19
                                        ;   in Loop: Header=BB21_12 Depth=2
	mov.w	-4(r4), r12
	add.w	#1, r12
	mov.w	r12, -4(r4)
	jmp	.LBB21_12
.LBB21_18:                              ; %commit_to_shadow.exit
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.b	#1, &commit_flag
	call	#__reset_partial_execution
	mov.w	&next_coalesced_task_addr, r12
	mov.w	r12, &coalesced_task_addr
	call	#__commit_to_store_buf
	mov.b	#0, &commit_flag
	mov.b	&decrease_target, r11
	cmp.b	#0, r11
	jeq	.LBB21_23
	jmp	.LBB21_19
.LBB21_19:                              ; %if.then.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.w	&target_budget, r12
	cmp.w	#2, r12
	jlo	.LBB21_21
	jmp	.LBB21_20
.LBB21_20:                              ; %if.then1.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.w	&target_budget, r12
	clrc
	rrc.w	r12
	mov.w	r12, &target_budget
	jmp	.LBB21_22
.LBB21_21:                              ; %if.else.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.b	#0, &decrease_target
	mov.w	&target_budget, r12
	rla.w	r12
	mov.w	r12, &target_budget
	jmp	.LBB21_22
.LBB21_22:                              ; %if.end.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	jmp	.LBB21_27
.LBB21_23:                              ; %if.else2.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.w	&target_budget, r12
	mov.w	&previous_history, r13
	cmp.w	r13, r12
	jhs	.LBB21_25
	jmp	.LBB21_24
.LBB21_24:                              ; %if.then4.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.w	&target_budget, r12
	rla.w	r12
	mov.w	r12, &target_budget
	jmp	.LBB21_26
.LBB21_25:                              ; %if.else6.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.b	#1, &decrease_target
	mov.w	&target_budget, r12
	clrc
	rrc.w	r12
	mov.w	r12, &target_budget
	jmp	.LBB21_26
.LBB21_26:                              ; %if.end8.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	jmp	.LBB21_27
.LBB21_27:                              ; %if.end9.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.w	&target_budget, r12
	cmp.w	#65, r12
	jlo	.LBB21_29
	jmp	.LBB21_28
.LBB21_28:                              ; %if.then11.i
                                        ;   in Loop: Header=BB21_8 Depth=1
	mov.w	#64, &target_budget
	jmp	.LBB21_29
.LBB21_29:                              ; %update_target_budget.exit
                                        ;   in Loop: Header=BB21_8 Depth=1
	jmp	.LBB21_8
.Lfunc_end21:
	.size	__scheduler, .Lfunc_end21-__scheduler

	.globl	__reset_partial_execution
	.align	2
	.type	__reset_partial_execution,@function
__reset_partial_execution:              ; @__reset_partial_execution
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	#0, &death_count
	mov.w	&TB0CTL, r12
	and.w	#-17, r12
	mov.w	r12, &TB0CTL
	mov.w	&TB0CTL, r12
	bis.w	#4, r12
	mov.w	r12, &TB0CTL
	pop.w	r4
	ret
.Lfunc_end22:
	.size	__reset_partial_execution, .Lfunc_end22-__reset_partial_execution

	.globl	__coala_force_commit
	.align	2
	.type	__coala_force_commit,@function
__coala_force_commit:                   ; @__coala_force_commit
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	&target_budget, r12
	mov.w	r12, &current_budget
	pop.w	r4
	ret
.Lfunc_end23:
	.size	__coala_force_commit, .Lfunc_end23-__coala_force_commit

	.globl	__return_addr_no_check
	.align	2
	.type	__return_addr_no_check,@function
__return_addr_no_check:                 ; @__return_addr_no_check
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#20, r1
	;DEBUG_VALUE: __return_addr_no_check:var_fram_addr <- [%FP+-4]
	mov.w	r15, r12
	mov.w	r15, -4(r4)
	mov.w	#0, -8(r4)
	mov.w	-4(r4), r15
	and.w	#-32, r15
	mov.w	r15, -12(r4)
	mov.w	&last_var_pg_tag, r13
	cmp.w	r13, r15
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	jne	.LBB24_2
	jmp	.LBB24_1
.LBB24_1:                               ; %if.then
	;DEBUG_VALUE: __return_addr_no_check:var_fram_addr <- [%FP+-4]
	mov.w	&last_ram_pg_tag, r12
	mov.w	-4(r4), r13
	and.w	#31, r13
	add.w	r13, r12
	mov.w	r12, -6(r4)
	mov.w	r12, -2(r4)
	jmp	.LBB24_12
.LBB24_2:                               ; %if.end
	;DEBUG_VALUE: __return_addr_no_check:var_fram_addr <- [%FP+-4]
	mov.w	-12(r4), r12
	mov.w	r12, &last_var_pg_tag
	jmp	.LBB24_3
.LBB24_3:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-8(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf+4(r15), r12
	mov.w	r12, -10(r4)
	cmp.w	#0, r12
	jeq	.LBB24_9
	jmp	.LBB24_4
.LBB24_4:                               ; %while.body
                                        ;   in Loop: Header=BB24_3 Depth=1
	mov.w	-10(r4), r12
	mov.w	-12(r4), r13
	cmp.w	r13, r12
	jne	.LBB24_6
	jmp	.LBB24_5
.LBB24_5:                               ; %if.then4
	mov.w	-8(r4), r12
	mov.w	r12, &last_ram_page_idx
	mov.w	-8(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf(r15), r12
	mov.w	r12, &last_ram_pg_tag
	mov.w	-4(r4), r13
	and.w	#31, r13
	add.w	r13, r12
	mov.w	r12, -6(r4)
	mov.w	r12, -2(r4)
	jmp	.LBB24_12
.LBB24_6:                               ; %if.end8
                                        ;   in Loop: Header=BB24_3 Depth=1
	mov.w	-8(r4), r12
	add.w	#1, r12
	mov.w	r12, -8(r4)
	cmp.w	#32, r12
	jne	.LBB24_8
	jmp	.LBB24_7
.LBB24_7:                               ; %if.then10
	jmp	.LBB24_9
.LBB24_8:                               ; %if.end11
                                        ;   in Loop: Header=BB24_3 Depth=1
	jmp	.LBB24_3
.LBB24_9:                               ; %while.end
	mov.w	-4(r4), r15
	mov.w	&swap_index, r12
	mov.w	#6, r13
	mov.w	r15, -16(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	mov.w	r13, r14
	mov.w	r13, -18(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	add.w	#ram_pages_buf, r15
	mov.w	-16(r4), r12            ; 2-byte Folded Reload
	mov.w	r15, -20(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	mov.w	-20(r4), r14            ; 2-byte Folded Reload
	call	#__swap_page
	mov.w	&swap_index, r12
	mov.w	r12, &last_ram_page_idx
	mov.w	&swap_index, r15
	mov.w	-18(r4), r14            ; 2-byte Folded Reload
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf(r15), r12
	mov.w	r12, &last_ram_pg_tag
	mov.w	&swap_index, r12
	add.w	#1, r12
	mov.w	r12, &swap_index
	mov.w	&swap_index, r12
	cmp.w	#32, r12
	jlo	.LBB24_11
	jmp	.LBB24_10
.LBB24_10:                              ; %if.then17
	mov.w	#0, &swap_index
	jmp	.LBB24_11
.LBB24_11:                              ; %if.end18
	mov.w	&last_ram_pg_tag, r12
	mov.w	-4(r4), r13
	and.w	#31, r13
	add.w	r13, r12
	mov.w	r12, -6(r4)
	mov.w	r12, -2(r4)
	jmp	.LBB24_12
.LBB24_12:                              ; %return
	mov.w	-2(r4), r15
	add.w	#20, r1
	pop.w	r4
	ret
.Lfunc_end24:
	.size	__return_addr_no_check, .Lfunc_end24-__return_addr_no_check

	.globl	__swap_page
	.align	2
	.type	__swap_page,@function
__swap_page:                            ; @__swap_page
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#30, r1
	;DEBUG_VALUE: __swap_page:var_fram_addr <- [%FP+-18]
	;DEBUG_VALUE: __swap_page:victim <- [%FP+-20]
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -20(r4)
	mov.w	r14, -22(r4)
	mov.w	&page_fault_counter, r14
	add.w	#1, r14
	mov.w	r14, &page_fault_counter
	mov.w	-22(r4), r14
	mov.b	2(r14), r11
	cmp.b	#0, r11
	mov.w	r12, -30(r4)            ; 2-byte Folded Spill
	mov.w	r13, -32(r4)            ; 2-byte Folded Spill
	jeq	.LBB25_2
	jmp	.LBB25_1
.LBB25_1:                               ; %if.then
	;DEBUG_VALUE: __swap_page:victim <- [%FP+-20]
	;DEBUG_VALUE: __swap_page:var_fram_addr <- [%FP+-18]
	mov.w	&fullpage_fault_counter, r12
	add.w	#1, r12
	mov.w	r12, &fullpage_fault_counter
	jmp	.LBB25_2
.LBB25_2:                               ; %if.end
	;DEBUG_VALUE: __swap_page:victim <- [%FP+-20]
	;DEBUG_VALUE: __swap_page:var_fram_addr <- [%FP+-18]
	;DEBUG_VALUE: __swap_page:page_pt <- [%FP+-22]
	;DEBUG_VALUE: __swap_page:page_idx <- [%FP+-24]
	;DEBUG_VALUE: __swap_page:i <- [%FP+-26]
	mov.w	#0, -28(r4)
	jmp	.LBB25_3
.LBB25_3:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-28(r4), r12
	mov.w	&shadow_buf_pages_count, r13
	cmp.w	r13, r12
	jhs	.LBB25_12
	jmp	.LBB25_4
.LBB25_4:                               ; %while.body
                                        ;   in Loop: Header=BB25_3 Depth=1
	mov.w	-28(r4), r12
	mov.b	shadow_buf_pages(r12), r12
	mov.w	r12, -26(r4)
	rla.w	r12
	rla.w	r12
	rla.w	r12
	rla.w	r12
	rla.w	r12
	add.w	#-16640, r12
	mov.w	r12, -24(r4)
	mov.w	-20(r4), r13
	and.w	#-32, r13
	cmp.w	r13, r12
	jne	.LBB25_11
	jmp	.LBB25_5
.LBB25_5:                               ; %if.then4
	mov.w	-22(r4), r12
	mov.b	2(r12), r13
	cmp.b	#0, r13
	jeq	.LBB25_7
	jmp	.LBB25_6
.LBB25_6:                               ; %if.then7
	mov.w	-22(r4), r12
	mov.w	0(r12), r15
	mov.w	4(r12), r14
	call	#__copy_page_to_shadow_buf
	mov.w	-22(r4), r12
	mov.b	#0, 2(r12)
	jmp	.LBB25_7
.LBB25_7:                               ; %if.end9
	mov.w	-26(r4), r12
	mov.b	store_buf(r12), r13
	cmp.b	#0, r13
	jne	.LBB25_9
	jmp	.LBB25_8
.LBB25_8:                               ; %if.then12
	mov.w	-24(r4), r12
	add.w	#8192, r12
	mov.w	-22(r4), r13
	mov.w	0(r13), r13
	mov.w	r12, -16(r4)
	mov.w	r13, -18(r4)
	mov.w	-16(r4), r12
	mov.w	r12, &DMA1SAL
	mov.w	-18(r4), r12
	mov.w	r12, &DMA1DAL
	mov.w	&DMA1CTL, r12
	bis.w	#17, r12
	mov.w	r12, &DMA1CTL
	jmp	.LBB25_10
.LBB25_9:                               ; %if.else
	mov.w	-24(r4), r12
	mov.w	-22(r4), r13
	mov.w	0(r13), r13
	mov.w	r12, -4(r4)
	mov.w	r13, -6(r4)
	mov.w	-4(r4), r12
	mov.w	r12, &DMA1SAL
	mov.w	-6(r4), r12
	mov.w	r12, &DMA1DAL
	mov.w	&DMA1CTL, r12
	bis.w	#17, r12
	mov.w	r12, &DMA1CTL
	jmp	.LBB25_10
.LBB25_10:                              ; %if.end16
	jmp	.LBB25_18
.LBB25_11:                              ; %if.end17
                                        ;   in Loop: Header=BB25_3 Depth=1
	mov.w	-28(r4), r12
	add.w	#1, r12
	mov.w	r12, -28(r4)
	jmp	.LBB25_3
.LBB25_12:                              ; %while.end
	mov.w	-20(r4), r12
	and.w	#-32, r12
	mov.w	r12, -24(r4)
	add.w	#16640, r12
	clrc
	rrc.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	mov.w	r12, -26(r4)
	mov.w	-22(r4), r12
	mov.b	2(r12), r13
	cmp.b	#0, r13
	jeq	.LBB25_14
	jmp	.LBB25_13
.LBB25_13:                              ; %if.then22
	mov.w	-22(r4), r12
	mov.w	0(r12), r15
	mov.w	4(r12), r14
	call	#__copy_page_to_shadow_buf
	mov.w	-22(r4), r12
	mov.b	#0, 2(r12)
	jmp	.LBB25_14
.LBB25_14:                              ; %if.end26
	mov.w	-26(r4), r12
	mov.b	store_buf(r12), r13
	cmp.b	#0, r13
	jne	.LBB25_16
	jmp	.LBB25_15
.LBB25_15:                              ; %if.then29
	mov.w	-24(r4), r12
	mov.w	-22(r4), r13
	mov.w	0(r13), r13
	mov.w	r12, -8(r4)
	mov.w	r13, -10(r4)
	mov.w	-8(r4), r12
	mov.w	r12, &DMA1SAL
	mov.w	-10(r4), r12
	mov.w	r12, &DMA1DAL
	mov.w	&DMA1CTL, r12
	bis.w	#17, r12
	mov.w	r12, &DMA1CTL
	jmp	.LBB25_17
.LBB25_16:                              ; %if.else31
	mov.w	-24(r4), r12
	add.w	#8192, r12
	mov.w	-22(r4), r13
	mov.w	0(r13), r13
	mov.w	r12, -12(r4)
	mov.w	r13, -14(r4)
	mov.w	-12(r4), r12
	mov.w	r12, &DMA1SAL
	mov.w	-14(r4), r12
	mov.w	r12, &DMA1DAL
	mov.w	&DMA1CTL, r12
	bis.w	#17, r12
	mov.w	r12, &DMA1CTL
	jmp	.LBB25_17
.LBB25_17:                              ; %if.end34
	jmp	.LBB25_18
.LBB25_18:                              ; %PAG_IN_TEMP
	mov.w	-24(r4), r12
	mov.w	-22(r4), r13
	mov.w	r12, 4(r13)
	add.w	#30, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end25:
	.size	__swap_page, .Lfunc_end25-__swap_page

	.globl	__return_addr_wr_no_check
	.align	2
	.type	__return_addr_wr_no_check,@function
__return_addr_wr_no_check:              ; @__return_addr_wr_no_check
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#22, r1
	;DEBUG_VALUE: __return_addr_wr_no_check:var_fram_addr <- [%FP+-4]
	mov.w	r15, r12
	mov.w	r15, -4(r4)
	mov.w	#0, -8(r4)
	mov.w	-4(r4), r15
	and.w	#-32, r15
	mov.w	r15, -12(r4)
	mov.w	&last_var_pg_tag, r13
	cmp.w	r13, r15
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	jne	.LBB26_2
	jmp	.LBB26_1
.LBB26_1:                               ; %if.then
	;DEBUG_VALUE: __return_addr_wr_no_check:var_fram_addr <- [%FP+-4]
	mov.w	&last_ram_page_idx, r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.b	#1, ram_pages_buf+2(r15)
	mov.w	&last_ram_pg_tag, r12
	mov.w	-4(r4), r13
	and.w	#31, r13
	add.w	r13, r12
	mov.w	r12, -6(r4)
	mov.w	r12, -2(r4)
	jmp	.LBB26_12
.LBB26_2:                               ; %if.end
	;DEBUG_VALUE: __return_addr_wr_no_check:var_fram_addr <- [%FP+-4]
	mov.w	-12(r4), r12
	mov.w	r12, &last_var_pg_tag
	jmp	.LBB26_3
.LBB26_3:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-8(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf+4(r15), r12
	mov.w	r12, -10(r4)
	cmp.w	#0, r12
	jeq	.LBB26_9
	jmp	.LBB26_4
.LBB26_4:                               ; %while.body
                                        ;   in Loop: Header=BB26_3 Depth=1
	mov.w	-10(r4), r12
	mov.w	-12(r4), r13
	cmp.w	r13, r12
	jne	.LBB26_6
	jmp	.LBB26_5
.LBB26_5:                               ; %if.then5
	mov.w	-8(r4), r15
	mov.w	#6, r12
	mov.w	r12, r14
	mov.w	r12, -16(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.b	#1, ram_pages_buf+2(r15)
	mov.w	-8(r4), r12
	mov.w	r12, &last_ram_page_idx
	mov.w	-8(r4), r15
	mov.w	-16(r4), r14            ; 2-byte Folded Reload
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf(r15), r12
	mov.w	r12, &last_ram_pg_tag
	mov.w	-4(r4), r13
	and.w	#31, r13
	add.w	r13, r12
	mov.w	r12, -6(r4)
	mov.w	r12, -2(r4)
	jmp	.LBB26_12
.LBB26_6:                               ; %if.end11
                                        ;   in Loop: Header=BB26_3 Depth=1
	mov.w	-8(r4), r12
	add.w	#1, r12
	mov.w	r12, -8(r4)
	cmp.w	#32, r12
	jne	.LBB26_8
	jmp	.LBB26_7
.LBB26_7:                               ; %if.then13
	jmp	.LBB26_9
.LBB26_8:                               ; %if.end14
                                        ;   in Loop: Header=BB26_3 Depth=1
	jmp	.LBB26_3
.LBB26_9:                               ; %while.end
	mov.w	-4(r4), r15
	mov.w	&swap_index, r12
	mov.w	#6, r13
	mov.w	r15, -18(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	mov.w	r13, r14
	mov.w	r13, -20(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	add.w	#ram_pages_buf, r15
	mov.w	-18(r4), r12            ; 2-byte Folded Reload
	mov.w	r15, -22(r4)            ; 2-byte Folded Spill
	mov.w	r12, r15
	mov.w	-22(r4), r14            ; 2-byte Folded Reload
	call	#__swap_page
	mov.w	&swap_index, r15
	mov.w	-20(r4), r14            ; 2-byte Folded Reload
	call	#__mulhi3hw_noint
	mov.b	#1, ram_pages_buf+2(r15)
	mov.w	&swap_index, r12
	mov.w	r12, &last_ram_page_idx
	mov.w	&swap_index, r15
	mov.w	-20(r4), r14            ; 2-byte Folded Reload
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf(r15), r12
	mov.w	r12, &last_ram_pg_tag
	mov.w	&swap_index, r12
	add.w	#1, r12
	mov.w	r12, &swap_index
	mov.w	&swap_index, r12
	cmp.w	#32, r12
	jlo	.LBB26_11
	jmp	.LBB26_10
.LBB26_10:                              ; %if.then22
	mov.w	#0, &swap_index
	jmp	.LBB26_11
.LBB26_11:                              ; %if.end23
	mov.w	&last_ram_pg_tag, r12
	mov.w	-4(r4), r13
	and.w	#31, r13
	add.w	r13, r12
	mov.w	r12, -6(r4)
	mov.w	r12, -2(r4)
	jmp	.LBB26_12
.LBB26_12:                              ; %return
	mov.w	-2(r4), r15
	add.w	#22, r1
	pop.w	r4
	ret
.Lfunc_end26:
	.size	__return_addr_wr_no_check, .Lfunc_end26-__return_addr_wr_no_check

	.globl	__dma_copy_page
	.align	2
	.type	__dma_copy_page,@function
__dma_copy_page:                        ; @__dma_copy_page
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	;DEBUG_VALUE: __dma_copy_page:src_page <- [%FP+-2]
	;DEBUG_VALUE: __dma_copy_page:dst_page <- [%FP+-4]
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	mov.w	-2(r4), r14
	mov.w	r14, &DMA1SAL
	mov.w	-4(r4), r14
	mov.w	r14, &DMA1DAL
	mov.w	&DMA1CTL, r14
	bis.w	#17, r14
	mov.w	r14, &DMA1CTL
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	mov.w	r13, -8(r4)             ; 2-byte Folded Spill
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end27:
	.size	__dma_copy_page, .Lfunc_end27-__dma_copy_page

	.globl	__schedule_partial_execution_commit
	.align	2
	.type	__schedule_partial_execution_commit,@function
__schedule_partial_execution_commit:    ; @__schedule_partial_execution_commit
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#16, &TB0CCTL0
	mov.w	&pe_ccr, r12
	mov.w	r12, &TB0CCR0
	mov.w	#1, &TB0EX0
	mov.w	#724, &TB0CTL
	;APP
	bis.w #8, SR  nop
	;NO_APP
	;APP
	nop
	;NO_APP
	pop.w	r4
	ret
.Lfunc_end28:
	.size	__schedule_partial_execution_commit, .Lfunc_end28-__schedule_partial_execution_commit

	.globl	__partial_execution_init
	.align	2
	.type	__partial_execution_init,@function
__partial_execution_init:               ; @__partial_execution_init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	&checkpoint_available, r12
	cmp.b	#0, r12
	jne	.LBB29_2
	jmp	.LBB29_1
.LBB29_1:                               ; %if.then
	mov.w	#-17664, &last_cp_buf
	mov.b	#0, &restoring
	jmp	.LBB29_2
.LBB29_2:                               ; %if.end
	mov.b	&death_count, r12
	cmp.w	#2, r12
	jge	.LBB29_6
	jmp	.LBB29_3
.LBB29_3:                               ; %if.then2
	mov.w	&target_budget, r12
	cmp.w	#1, r12
	jne	.LBB29_5
	jmp	.LBB29_4
.LBB29_4:                               ; %if.then5
	mov.b	&death_count, r12
	add.b	#1, r12
	mov.b	r12, &death_count
	jmp	.LBB29_5
.LBB29_5:                               ; %if.end6
	jmp	.LBB29_13
.LBB29_6:                               ; %if.else
	mov.b	&death_count, r12
	cmp.b	#2, r12
	jne	.LBB29_8
	jmp	.LBB29_7
.LBB29_7:                               ; %if.then10
	mov.b	&death_count, r12
	add.b	#1, r12
	mov.b	r12, &death_count
	jmp	.LBB29_12
.LBB29_8:                               ; %if.else12
	mov.w	&succ_pe_ccr, r12
	cmp.w	#0, r12
	jeq	.LBB29_10
	jmp	.LBB29_9
.LBB29_9:                               ; %if.then14
	mov.w	&succ_pe_ccr, r12
	mov.w	r12, &pe_ccr
	mov.w	#0, &succ_pe_ccr
	jmp	.LBB29_11
.LBB29_10:                              ; %if.else15
	mov.w	&pe_ccr, r12
	clrc
	rrc.w	r12
	mov.w	r12, &pe_ccr
	jmp	.LBB29_11
.LBB29_11:                              ; %if.end16
	jmp	.LBB29_12
.LBB29_12:                              ; %if.end17
	call	#__schedule_partial_execution_commit
	jmp	.LBB29_13
.LBB29_13:                              ; %if.end18
	pop.w	r4
	ret
.Lfunc_end29:
	.size	__partial_execution_init, .Lfunc_end29-__partial_execution_init

	.globl	reboot_prologue
	.align	2
	.type	reboot_prologue,@function
reboot_prologue:                        ; @reboot_prologue
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	&history, r12
	clrc
	rrc.w	r12
	add.w	#1, r12
	mov.w	r12, &target_budget
	mov.w	&history, r12
	mov.w	r12, &previous_history
	mov.w	#0, &history
	pop.w	r4
	ret
.Lfunc_end30:
	.size	reboot_prologue, .Lfunc_end30-reboot_prologue

	.globl	recall_persistent_state
	.align	2
	.type	recall_persistent_state,@function
recall_persistent_state:                ; @recall_persistent_state
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	&next_coalesced_task_addr, r12
	mov.w	r12, &coalesced_task_addr
	pop.w	r4
	ret
.Lfunc_end31:
	.size	recall_persistent_state, .Lfunc_end31-recall_persistent_state

	.globl	initialize_sram_buffer
	.align	2
	.type	initialize_sram_buffer,@function
initialize_sram_buffer:                 ; @initialize_sram_buffer
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#6, r1
	mov.w	#7168, -4(r4)
	mov.w	#0, -2(r4)
	jmp	.LBB32_1
.LBB32_1:                               ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-2(r4), r12
	cmp.w	#32, r12
	jhs	.LBB32_4
	jmp	.LBB32_2
.LBB32_2:                               ; %for.body
                                        ;   in Loop: Header=BB32_1 Depth=1
	mov.w	-4(r4), r12
	mov.w	-2(r4), r15
	mov.w	#6, r14
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-6(r4), r12             ; 2-byte Folded Reload
	mov.w	r12, ram_pages_buf(r15)
	mov.w	-4(r4), r12
	add.w	#32, r12
	mov.w	r12, -4(r4)
	jmp	.LBB32_3
.LBB32_3:                               ; %for.inc
                                        ;   in Loop: Header=BB32_1 Depth=1
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB32_1
.LBB32_4:                               ; %for.end
	add.w	#6, r1
	pop.w	r4
	ret
.Lfunc_end32:
	.size	initialize_sram_buffer, .Lfunc_end32-initialize_sram_buffer

	.globl	recall_coalescing_state
	.align	2
	.type	recall_coalescing_state,@function
recall_coalescing_state:                ; @recall_coalescing_state
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	&coalesced_task_addr, r12
	mov.w	r12, &real_task_addr
	pop.w	r4
	ret
.Lfunc_end33:
	.size	recall_coalescing_state, .Lfunc_end33-recall_coalescing_state

	.globl	static_task_epilogue
	.align	2
	.type	static_task_epilogue,@function
static_task_epilogue:                   ; @static_task_epilogue
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	&next_real_task_addr, r12
	mov.w	r12, &real_task_addr
	mov.w	&current_budget, r12
	add.w	#1, r12
	mov.w	r12, &current_budget
	mov.w	&history, r12
	add.w	#1, r12
	mov.w	r12, &history
	pop.w	r4
	ret
.Lfunc_end34:
	.size	static_task_epilogue, .Lfunc_end34-static_task_epilogue

	.globl	save_volatile_state
	.align	2
	.type	save_volatile_state,@function
save_volatile_state:                    ; @save_volatile_state
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	&real_task_addr, r12
	mov.w	r12, &next_coalesced_task_addr
	pop.w	r4
	ret
.Lfunc_end35:
	.size	save_volatile_state, .Lfunc_end35-save_volatile_state

	.globl	commit_to_shadow
	.align	2
	.type	commit_to_shadow,@function
commit_to_shadow:                       ; @commit_to_shadow
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#6, r1
	mov.w	#0, -4(r4)
	jmp	.LBB36_1
.LBB36_1:                               ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-4(r4), r12
	mov.b	#0, r13
	cmp.w	#32, r12
	mov.b	r13, -5(r4)             ; 1-byte Folded Spill
	jhs	.LBB36_3
	jmp	.LBB36_2
.LBB36_2:                               ; %land.rhs
                                        ;   in Loop: Header=BB36_1 Depth=1
	mov.w	-4(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf+4(r15), r12
	cmp.w	#0, r12
	mov.w	r2, r12
	rra.w	r12
	mov.w	#1, r13
	bic.w	r12, r13
	mov.b	r13, r11
	mov.b	r11, -5(r4)             ; 1-byte Folded Spill
	jmp	.LBB36_3
.LBB36_3:                               ; %land.end
                                        ;   in Loop: Header=BB36_1 Depth=1
	mov.b	-5(r4), r12             ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB36_8
	jmp	.LBB36_4
.LBB36_4:                               ; %for.body
                                        ;   in Loop: Header=BB36_1 Depth=1
	mov.w	-4(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.b	ram_pages_buf+2(r15), r11
	cmp.b	#0, r11
	jeq	.LBB36_6
	jmp	.LBB36_5
.LBB36_5:                               ; %if.then
                                        ;   in Loop: Header=BB36_1 Depth=1
	mov.w	-4(r4), r15
	mov.w	#6, r12
	mov.w	r12, r14
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	ram_pages_buf(r15), r12
	mov.w	ram_pages_buf+4(r15), r14
	mov.w	r12, r15
	call	#__copy_page_to_shadow_buf
	mov.w	-4(r4), r15
	mov.w	-8(r4), r14             ; 2-byte Folded Reload
	call	#__mulhi3hw_noint
	mov.b	#0, ram_pages_buf+2(r15)
	jmp	.LBB36_6
.LBB36_6:                               ; %if.end
                                        ;   in Loop: Header=BB36_1 Depth=1
	jmp	.LBB36_7
.LBB36_7:                               ; %for.inc
                                        ;   in Loop: Header=BB36_1 Depth=1
	mov.w	-4(r4), r12
	add.w	#1, r12
	mov.w	r12, -4(r4)
	jmp	.LBB36_1
.LBB36_8:                               ; %for.end
	add.w	#6, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end36:
	.size	commit_to_shadow, .Lfunc_end36-commit_to_shadow

	.globl	commit_to_store
	.align	2
	.type	commit_to_store,@function
commit_to_store:                        ; @commit_to_store
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	call	#__commit_to_store_buf
	pop.w	r4
	ret
.Lfunc_end37:
	.size	commit_to_store, .Lfunc_end37-commit_to_store

	.globl	update_target_budget
	.align	2
	.type	update_target_budget,@function
update_target_budget:                   ; @update_target_budget
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	&decrease_target, r12
	cmp.b	#0, r12
	jeq	.LBB38_5
	jmp	.LBB38_1
.LBB38_1:                               ; %if.then
	mov.w	&target_budget, r12
	cmp.w	#2, r12
	jlo	.LBB38_3
	jmp	.LBB38_2
.LBB38_2:                               ; %if.then1
	mov.w	&target_budget, r12
	clrc
	rrc.w	r12
	mov.w	r12, &target_budget
	jmp	.LBB38_4
.LBB38_3:                               ; %if.else
	mov.b	#0, &decrease_target
	mov.w	&target_budget, r12
	rla.w	r12
	mov.w	r12, &target_budget
	jmp	.LBB38_4
.LBB38_4:                               ; %if.end
	jmp	.LBB38_9
.LBB38_5:                               ; %if.else2
	mov.w	&target_budget, r12
	mov.w	&previous_history, r13
	cmp.w	r13, r12
	jhs	.LBB38_7
	jmp	.LBB38_6
.LBB38_6:                               ; %if.then4
	mov.w	&target_budget, r12
	rla.w	r12
	mov.w	r12, &target_budget
	jmp	.LBB38_8
.LBB38_7:                               ; %if.else6
	mov.b	#1, &decrease_target
	mov.w	&target_budget, r12
	clrc
	rrc.w	r12
	mov.w	r12, &target_budget
	jmp	.LBB38_8
.LBB38_8:                               ; %if.end8
	jmp	.LBB38_9
.LBB38_9:                               ; %if.end9
	mov.w	&target_budget, r12
	cmp.w	#65, r12
	jlo	.LBB38_11
	jmp	.LBB38_10
.LBB38_10:                              ; %if.then11
	mov.w	#64, &target_budget
	jmp	.LBB38_11
.LBB38_11:                              ; %if.end12
	pop.w	r4
	ret
.Lfunc_end38:
	.size	update_target_budget, .Lfunc_end38-update_target_budget

	.globl	uart_init_8mhz
	.align	2
	.type	uart_init_8mhz,@function
uart_init_8mhz:                         ; @uart_init_8mhz
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	&PASEL1_H, r12
	bis.w	#3, r12
	mov.b	r12, r13
	mov.b	r13, &PASEL1_H
	mov.b	&PASEL0_H, r12
	and.w	#252, r12
	mov.b	r12, r13
	mov.b	r13, &PASEL0_H
	mov.w	#1, &UCA0CTLW0
	mov.w	&UCA0CTLW0, r12
	bis.w	#128, r12
	mov.w	r12, &UCA0CTLW0
	mov.b	#4, &UCA0BRW_L
	mov.w	#21761, &UCA0MCTLW
	mov.b	#0, &UCA0BRW_H
	mov.b	&UCA0CTLW0_L, r12
	and.w	#254, r12
	mov.b	r12, r13
	mov.b	r13, &UCA0CTLW0_L
	pop.w	r4
	ret
.Lfunc_end39:
	.size	uart_init_8mhz, .Lfunc_end39-uart_init_8mhz

	.globl	uart_init
	.align	2
	.type	uart_init,@function
uart_init:                              ; @uart_init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	&PASEL1_H, r12
	bis.w	#3, r12
	mov.b	r12, r13
	mov.b	r13, &PASEL1_H
	mov.b	&PASEL0_H, r12
	and.w	#252, r12
	mov.b	r12, r13
	mov.b	r13, &PASEL0_H
	mov.w	#1, &UCA0CTLW0
	mov.w	&UCA0CTLW0, r12
	bis.w	#128, r12
	mov.w	r12, &UCA0CTLW0
	mov.b	#8, &UCA0BRW_L
	mov.w	&UCA0MCTLW, r12
	bis.w	#-10752, r12
	mov.w	r12, &UCA0MCTLW
	mov.b	#0, &UCA0BRW_H
	mov.b	&UCA0CTLW0_L, r12
	and.w	#254, r12
	mov.b	r12, r13
	mov.b	r13, &UCA0CTLW0_L
	pop.w	r4
	ret
.Lfunc_end40:
	.size	uart_init, .Lfunc_end40-uart_init

	.globl	uart_sendChar
	.align	2
	.type	uart_sendChar,@function
uart_sendChar:                          ; @uart_sendChar
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	;DEBUG_VALUE: uart_sendChar:c <- [%FP+-1]
	mov.b	r15, r12
	mov.b	r12, -1(r4)
	jmp	.LBB41_1
.LBB41_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB41_3
	jmp	.LBB41_2
.LBB41_2:                               ; %while.body
                                        ;   in Loop: Header=BB41_1 Depth=1
	jmp	.LBB41_1
.LBB41_3:                               ; %while.end
	mov.b	-1(r4), r12
	mov.w	r12, &UCA0TXBUF
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end41:
	.size	uart_sendChar, .Lfunc_end41-uart_sendChar

	.globl	uart_sendText
	.align	2
	.type	uart_sendText,@function
uart_sendText:                          ; @uart_sendText
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#10, r1
	;DEBUG_VALUE: uart_sendText:c <- [%FP+-2]
	;DEBUG_VALUE: uart_sendText:len <- [%FP+-4]
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	mov.w	#0, -6(r4)
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	mov.w	r13, -10(r4)            ; 2-byte Folded Spill
	jmp	.LBB42_1
.LBB42_1:                               ; %for.cond
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB42_3 Depth 2
	mov.w	-6(r4), r12
	mov.w	-4(r4), r13
	cmp.w	r13, r12
	jhs	.LBB42_7
	jmp	.LBB42_2
.LBB42_2:                               ; %for.body
                                        ;   in Loop: Header=BB42_1 Depth=1
	jmp	.LBB42_3
.LBB42_3:                               ; %while.cond
                                        ;   Parent Loop BB42_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB42_5
	jmp	.LBB42_4
.LBB42_4:                               ; %while.body
                                        ;   in Loop: Header=BB42_3 Depth=2
	jmp	.LBB42_3
.LBB42_5:                               ; %while.end
                                        ;   in Loop: Header=BB42_1 Depth=1
	mov.w	-2(r4), r12
	mov.b	0(r12), r12
	mov.w	r12, &UCA0TXBUF
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB42_6
.LBB42_6:                               ; %for.inc
                                        ;   in Loop: Header=BB42_1 Depth=1
	mov.w	-6(r4), r12
	add.w	#1, r12
	mov.w	r12, -6(r4)
	jmp	.LBB42_1
.LBB42_7:                               ; %for.end
	add.w	#10, r1
	pop.w	r4
	ret
.Lfunc_end42:
	.size	uart_sendText, .Lfunc_end42-uart_sendText

	.globl	uart_sendStr
	.align	2
	.type	uart_sendStr,@function
uart_sendStr:                           ; @uart_sendStr
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	;DEBUG_VALUE: uart_sendStr:c <- [%FP+-2]
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	r12, -4(r4)             ; 2-byte Folded Spill
	jmp	.LBB43_1
.LBB43_1:                               ; %while.cond
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB43_3 Depth 2
	mov.w	-2(r4), r12
	mov.b	0(r12), r13
	cmp.b	#0, r13
	jeq	.LBB43_6
	jmp	.LBB43_2
.LBB43_2:                               ; %while.body
                                        ;   in Loop: Header=BB43_1 Depth=1
	jmp	.LBB43_3
.LBB43_3:                               ; %while.cond1
                                        ;   Parent Loop BB43_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB43_5
	jmp	.LBB43_4
.LBB43_4:                               ; %while.body3
                                        ;   in Loop: Header=BB43_3 Depth=2
	jmp	.LBB43_3
.LBB43_5:                               ; %while.end
                                        ;   in Loop: Header=BB43_1 Depth=1
	mov.w	-2(r4), r12
	mov.b	0(r12), r12
	mov.w	r12, &UCA0TXBUF
	;APP
	pushm.a #1, r13
mov     #0, r13
dec     r13
jnz     $-2
popm.a  #1, r13
nop

	;NO_APP
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB43_1
.LBB43_6:                               ; %while.end4
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end43:
	.size	uart_sendStr, .Lfunc_end43-uart_sendStr

	.globl	uart_sendByte
	.align	2
	.type	uart_sendByte,@function
uart_sendByte:                          ; @uart_sendByte
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	;DEBUG_VALUE: uart_sendByte:n <- [%FP+-1]
	mov.b	r15, r12
	mov.b	r12, -1(r4)
	jmp	.LBB44_1
.LBB44_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB44_3
	jmp	.LBB44_2
.LBB44_2:                               ; %while.body
                                        ;   in Loop: Header=BB44_1 Depth=1
	jmp	.LBB44_1
.LBB44_3:                               ; %while.end
	mov.b	-1(r4), r12
	mov.w	r12, &UCA0TXBUF
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end44:
	.size	uart_sendByte, .Lfunc_end44-uart_sendByte

	.globl	uart_sendHex8
	.align	2
	.type	uart_sendHex8,@function
uart_sendHex8:                          ; @uart_sendHex8
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	;DEBUG_VALUE: uart_sendHex8:n <- [%FP+-1]
	mov.b	r15, r12
	mov.b	r12, -1(r4)
	mov.b	-1(r4), r15
	clrc
	rrc.w	r15
	rra.w	r15
	rra.w	r15
	rra.w	r15
	call	#uart_sendHex_digit
	;APP
	pushm.a #1, r13
mov     #0, r13
dec     r13
jnz     $-2
popm.a  #1, r13
nop

	;NO_APP
	mov.b	-1(r4), r12
	and.w	#15, r12
	mov.w	r12, r15
	call	#uart_sendHex_digit
	;APP
	pushm.a #1, r13
mov     #0, r13
dec     r13
jnz     $-2
popm.a  #1, r13
nop

	;NO_APP
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end45:
	.size	uart_sendHex8, .Lfunc_end45-uart_sendHex8

	.globl	uart_sendHex_digit
	.align	2
	.type	uart_sendHex_digit,@function
uart_sendHex_digit:                     ; @uart_sendHex_digit
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	mov.b	r15, r12
	mov.b	r12, -1(r4)
	mov.b	-1(r4), r15
	cmp.w	#10, r15
	jge	.LBB46_5
	jmp	.LBB46_1
.LBB46_1:                               ; %if.then
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	jmp	.LBB46_2
.LBB46_2:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB46_4
	jmp	.LBB46_3
.LBB46_3:                               ; %while.body
                                        ;   in Loop: Header=BB46_2 Depth=1
	jmp	.LBB46_2
.LBB46_4:                               ; %while.end
	mov.b	-1(r4), r12
	add.w	#48, r12
	mov.w	r12, &UCA0TXBUF
	jmp	.LBB46_45
.LBB46_5:                               ; %if.else
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	mov.b	-1(r4), r12
	cmp.b	#10, r12
	jne	.LBB46_10
	jmp	.LBB46_6
.LBB46_6:                               ; %if.then6
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	jmp	.LBB46_7
.LBB46_7:                               ; %while.cond7
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB46_9
	jmp	.LBB46_8
.LBB46_8:                               ; %while.body11
                                        ;   in Loop: Header=BB46_7 Depth=1
	jmp	.LBB46_7
.LBB46_9:                               ; %while.end12
	mov.w	#65, &UCA0TXBUF
	jmp	.LBB46_44
.LBB46_10:                              ; %if.else13
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	mov.b	-1(r4), r12
	cmp.b	#11, r12
	jne	.LBB46_15
	jmp	.LBB46_11
.LBB46_11:                              ; %if.then17
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	jmp	.LBB46_12
.LBB46_12:                              ; %while.cond18
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB46_14
	jmp	.LBB46_13
.LBB46_13:                              ; %while.body22
                                        ;   in Loop: Header=BB46_12 Depth=1
	jmp	.LBB46_12
.LBB46_14:                              ; %while.end23
	mov.w	#66, &UCA0TXBUF
	jmp	.LBB46_43
.LBB46_15:                              ; %if.else24
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	mov.b	-1(r4), r12
	cmp.b	#12, r12
	jne	.LBB46_20
	jmp	.LBB46_16
.LBB46_16:                              ; %if.then28
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	jmp	.LBB46_17
.LBB46_17:                              ; %while.cond29
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB46_19
	jmp	.LBB46_18
.LBB46_18:                              ; %while.body33
                                        ;   in Loop: Header=BB46_17 Depth=1
	jmp	.LBB46_17
.LBB46_19:                              ; %while.end34
	mov.w	#67, &UCA0TXBUF
	jmp	.LBB46_42
.LBB46_20:                              ; %if.else35
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	mov.b	-1(r4), r12
	cmp.b	#13, r12
	jne	.LBB46_25
	jmp	.LBB46_21
.LBB46_21:                              ; %if.then39
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	jmp	.LBB46_22
.LBB46_22:                              ; %while.cond40
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB46_24
	jmp	.LBB46_23
.LBB46_23:                              ; %while.body44
                                        ;   in Loop: Header=BB46_22 Depth=1
	jmp	.LBB46_22
.LBB46_24:                              ; %while.end45
	mov.w	#68, &UCA0TXBUF
	jmp	.LBB46_41
.LBB46_25:                              ; %if.else46
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	mov.b	-1(r4), r12
	cmp.b	#14, r12
	jne	.LBB46_30
	jmp	.LBB46_26
.LBB46_26:                              ; %if.then50
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	jmp	.LBB46_27
.LBB46_27:                              ; %while.cond51
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB46_29
	jmp	.LBB46_28
.LBB46_28:                              ; %while.body55
                                        ;   in Loop: Header=BB46_27 Depth=1
	jmp	.LBB46_27
.LBB46_29:                              ; %while.end56
	mov.w	#69, &UCA0TXBUF
	jmp	.LBB46_40
.LBB46_30:                              ; %if.else57
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	mov.b	-1(r4), r12
	cmp.b	#15, r12
	jne	.LBB46_35
	jmp	.LBB46_31
.LBB46_31:                              ; %if.then61
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	jmp	.LBB46_32
.LBB46_32:                              ; %while.cond62
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB46_34
	jmp	.LBB46_33
.LBB46_33:                              ; %while.body66
                                        ;   in Loop: Header=BB46_32 Depth=1
	jmp	.LBB46_32
.LBB46_34:                              ; %while.end67
	mov.w	#70, &UCA0TXBUF
	jmp	.LBB46_39
.LBB46_35:                              ; %if.else68
	;DEBUG_VALUE: uart_sendHex_digit:n <- [%FP+-1]
	jmp	.LBB46_36
.LBB46_36:                              ; %while.cond69
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB46_38
	jmp	.LBB46_37
.LBB46_37:                              ; %while.body73
                                        ;   in Loop: Header=BB46_36 Depth=1
	jmp	.LBB46_36
.LBB46_38:                              ; %while.end74
	mov.b	-1(r4), r12
	mov.w	r12, &UCA0TXBUF
	jmp	.LBB46_39
.LBB46_39:                              ; %if.end
	jmp	.LBB46_40
.LBB46_40:                              ; %if.end77
	jmp	.LBB46_41
.LBB46_41:                              ; %if.end78
	jmp	.LBB46_42
.LBB46_42:                              ; %if.end79
	jmp	.LBB46_43
.LBB46_43:                              ; %if.end80
	jmp	.LBB46_44
.LBB46_44:                              ; %if.end81
	jmp	.LBB46_45
.LBB46_45:                              ; %if.end82
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end46:
	.size	uart_sendHex_digit, .Lfunc_end46-uart_sendHex_digit

	.globl	uart_sendHex16
	.align	2
	.type	uart_sendHex16,@function
uart_sendHex16:                         ; @uart_sendHex16
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	;DEBUG_VALUE: uart_sendHex16:n <- [%FP+-2]
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.b	-1(r4), r15
	mov.w	r12, -4(r4)             ; 2-byte Folded Spill
	call	#uart_sendHex8
	mov.b	-2(r4), r15
	call	#uart_sendHex8
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end47:
	.size	uart_sendHex16, .Lfunc_end47-uart_sendHex16

	.globl	uart_sendHex32
	.align	2
	.type	uart_sendHex32,@function
uart_sendHex32:                         ; @uart_sendHex32
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	;DEBUG_VALUE: uart_sendHex32:n <- [%FP+-4]
	mov.w	r15, r12
	mov.w	r14, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	mov.w	-2(r4), r15
	mov.w	r13, -6(r4)             ; 2-byte Folded Spill
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	call	#uart_sendHex16
	mov.w	-4(r4), r15
	call	#uart_sendHex16
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end48:
	.size	uart_sendHex32, .Lfunc_end48-uart_sendHex32

	.globl	TIMER0_B1_ISR
	.align	2
	.type	TIMER0_B1_ISR,@function
TIMER0_B1_ISR:                          ; @TIMER0_B1_ISR
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r15
	push.w	r14
	push.w	r13
	push.w	r12
	sub.w	#2, r1
	mov.w	&TB0IV, r12
	cmp.w	#15, r12
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	jhs	.LBB49_10
; BB#1:                                 ; %entry
	mov.w	#2, r14
	mov.w	-10(r4), r15            ; 2-byte Folded Reload
	call	#__mulhi3hw_noint
	mov.w	.LJTI49_0(r15), r12
	br	r12
.LBB49_2:                               ; %sw.bb
	jmp	.LBB49_11
.LBB49_3:                               ; %sw.bb1
	jmp	.LBB49_11
.LBB49_4:                               ; %sw.bb2
	jmp	.LBB49_11
.LBB49_5:                               ; %sw.bb3
	jmp	.LBB49_11
.LBB49_6:                               ; %sw.bb4
	jmp	.LBB49_11
.LBB49_7:                               ; %sw.bb5
	jmp	.LBB49_11
.LBB49_8:                               ; %sw.bb6
	jmp	.LBB49_11
.LBB49_9:                               ; %sw.bb7
	mov.w	&overflow, r12
	add.w	#1, r12
	mov.w	r12, &overflow
	jmp	.LBB49_11
.LBB49_10:                              ; %sw.default
	jmp	.LBB49_11
.LBB49_11:                              ; %sw.epilog
	add.w	#2, r1
	pop.w	r12
	pop.w	r13
	pop.w	r14
	pop.w	r15
	pop.w	r4
	reti
.Lfunc_end49:
	.size	TIMER0_B1_ISR, .Lfunc_end49-TIMER0_B1_ISR
	.section	.rodata,"a",@progbits
	.align	1
.LJTI49_0:
	.short	.LBB49_2
	.short	.LBB49_10
	.short	.LBB49_3
	.short	.LBB49_10
	.short	.LBB49_4
	.short	.LBB49_10
	.short	.LBB49_5
	.short	.LBB49_10
	.short	.LBB49_6
	.short	.LBB49_10
	.short	.LBB49_7
	.short	.LBB49_10
	.short	.LBB49_8
	.short	.LBB49_10
	.short	.LBB49_9

	.text
	.globl	msp_profiler_start
	.align	2
	.type	msp_profiler_start,@function
msp_profiler_start:                     ; @msp_profiler_start
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#550, &TB0CTL
	;APP
	nop { eint { nop
	;NO_APP
	pop.w	r4
	ret
.Lfunc_end50:
	.size	msp_profiler_start, .Lfunc_end50-msp_profiler_start

	.globl	msp_profiler_stop
	.align	2
	.type	msp_profiler_stop,@function
msp_profiler_stop:                      ; @msp_profiler_stop
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	mov.w	&TB0CTL, r12
	xor.w	#32, r12
	mov.w	r12, &TB0CTL
	;APP
	dint { nop
	;NO_APP
	mov.w	&overflow, r12
	mov.w	r12, -4(r4)
	mov.w	#0, -2(r4)
	mov.w	r12, -2(r4)
	mov.w	#0, -4(r4)
	mov.w	&TB0R, r12
	add.w	#-10, r12
	mov.w	-4(r4), r13
	mov.w	-2(r4), r14
	add.w	r12, r13
	addc.w	#0, r14
	mov.w	r14, -2(r4)
	mov.w	r13, -4(r4)
	mov.w	&TB0CTL, r12
	bis.w	#4, r12
	mov.w	r12, &TB0CTL
	mov.w	#0, &overflow
	mov.w	-4(r4), r14
	mov.w	-2(r4), r15
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end51:
	.size	msp_profiler_stop, .Lfunc_end51-msp_profiler_stop

	.globl	cp_init
	.align	2
	.type	cp_init,@function
cp_init:                                ; @cp_init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#550, &TB0CTL
	pop.w	r4
	ret
.Lfunc_end52:
	.size	cp_init, .Lfunc_end52-cp_init

	.globl	cp_getRes
	.align	2
	.type	cp_getRes,@function
cp_getRes:                              ; @cp_getRes
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	mov.w	&TB0R, r12
	mov.w	r12, -2(r4)
	mov.w	&__overflow, r12
	mov.w	r12, -8(r4)
	mov.w	#0, -6(r4)
	mov.w	r12, -6(r4)
	mov.w	#0, -8(r4)
	mov.w	-2(r4), r13
	mov.w	r12, -6(r4)
	mov.w	r13, -8(r4)
	add.w	#-10, r13
	addc.w	#-1, r12
	mov.w	r12, -6(r4)
	mov.w	r13, -8(r4)
	mov.w	#0, &__overflow
	mov.w	&TB0CTL, r12
	bis.w	#4, r12
	mov.w	r12, &TB0CTL
	mov.w	-2(r4), r14
	mov.w	#0, r15
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end53:
	.size	cp_getRes, .Lfunc_end53-cp_getRes

	.globl	cp_sendRes
	.align	2
	.type	cp_sendRes,@function
cp_sendRes:                             ; @cp_sendRes
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#6, r1
	;DEBUG_VALUE: cp_sendRes:resId <- [%FP+-2]
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	;APP
	dint { nop
	;NO_APP
	mov.w	&TB0R, r15
	mov.w	r15, -4(r4)
	add.w	#-15, r15
	mov.w	r15, -4(r4)
	mov.w	-2(r4), r15
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	call	#uart_sendStr
	mov.w	&__overflow, r15
	call	#uart_sendHex16
	mov.w	-4(r4), r15
	call	#uart_sendHex16
	mov.w	#.L.str, r15
	mov.w	#2, r14
	call	#uart_sendText
	mov.w	#0, &__overflow
	;APP
	nop { eint { nop
	;NO_APP
	mov.w	&TB0CTL, r12
	bis.w	#4, r12
	mov.w	r12, &TB0CTL
	add.w	#6, r1
	pop.w	r4
	ret
.Lfunc_end54:
	.size	cp_sendRes, .Lfunc_end54-cp_sendRes

	.globl	Timer0_A0_ISR
	.align	2
	.type	Timer0_A0_ISR,@function
Timer0_A0_ISR:                          ; @Timer0_A0_ISR
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	;APP
	bic.w #8, SR  nop
	;NO_APP
	;APP
	nop
	;NO_APP
	mov.w	#-23292, &PMMCTL0
	pop.w	r4
	reti
.Lfunc_end55:
	.size	Timer0_A0_ISR, .Lfunc_end55-Timer0_A0_ISR

	.globl	msp_reseter_reset
	.align	2
	.type	msp_reseter_reset,@function
msp_reseter_reset:                      ; @msp_reseter_reset
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	&reset, r12
	cmp.w	#0, r12
	jeq	.LBB56_2
	jmp	.LBB56_1
.LBB56_1:                               ; %if.then
	mov.w	#0, &reset
	mov.w	#-23292, &PMMCTL0
	jmp	.LBB56_3
.LBB56_2:                               ; %if.else
	mov.w	#1, &reset
	jmp	.LBB56_3
.LBB56_3:                               ; %if.end
	pop.w	r4
	ret
.Lfunc_end56:
	.size	msp_reseter_reset, .Lfunc_end56-msp_reseter_reset

	.globl	msp_reseter_confirm
	.align	2
	.type	msp_reseter_confirm,@function
msp_reseter_confirm:                    ; @msp_reseter_confirm
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	&reset, r12
	cmp.w	#0, r12
	jeq	.LBB57_2
	jmp	.LBB57_1
.LBB57_1:                               ; %if.then
	mov.w	#0, &reset
	mov.w	#-23292, &PMMCTL0
	jmp	.LBB57_3
.LBB57_2:                               ; %if.else
	mov.w	#1, &reset
	jmp	.LBB57_3
.LBB57_3:                               ; %if.end
	pop.w	r4
	ret
.Lfunc_end57:
	.size	msp_reseter_confirm, .Lfunc_end57-msp_reseter_confirm

	.globl	msp_reseter_auto
	.align	2
	.type	msp_reseter_auto,@function
msp_reseter_auto:                       ; @msp_reseter_auto
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	;DEBUG_VALUE: msp_reseter_auto:interval <- [%FP+-2]
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	#16, &TA0CCTL0
	mov.w	-2(r4), r15
	mov.w	r15, &TA0CCR0
	mov.w	#532, &TA0CTL
	;APP
	bis.w #8, SR  nop
	;NO_APP
	;APP
	nop
	;NO_APP
	mov.w	r12, -4(r4)             ; 2-byte Folded Spill
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end58:
	.size	msp_reseter_auto, .Lfunc_end58-msp_reseter_auto

	.globl	msp_reseter_auto_rand
	.align	2
	.type	msp_reseter_auto_rand,@function
msp_reseter_auto_rand:                  ; @msp_reseter_auto_rand
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	;DEBUG_VALUE: msp_reseter_auto_rand:interval <- [%FP+-2]
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	&noise_idx, r13
	rla.w	r13
	mov.w	noise(r13), r13
	mov.w	r13, r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	rra.w	r14
	add.w	r13, r15
	addc.w	#0, r14
	mov.w	r14, -6(r4)
	mov.w	r15, -8(r4)
	cmp.w	#0, r14
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	jge	.LBB59_2
	jmp	.LBB59_1
.LBB59_1:                               ; %if.then
	;DEBUG_VALUE: msp_reseter_auto_rand:interval <- [%FP+-2]
	mov.w	#10, -2(r4)
	jmp	.LBB59_6
.LBB59_2:                               ; %if.else
	;DEBUG_VALUE: msp_reseter_auto_rand:interval <- [%FP+-2]
	mov.w	-6(r4), r12
	cmp.w	#1, r12
	jl	.LBB59_4
	jmp	.LBB59_3
.LBB59_3:                               ; %if.then5
	;DEBUG_VALUE: msp_reseter_auto_rand:interval <- [%FP+-2]
	mov.w	#-1, -2(r4)
	jmp	.LBB59_5
.LBB59_4:                               ; %if.else6
	;DEBUG_VALUE: msp_reseter_auto_rand:interval <- [%FP+-2]
	mov.w	-8(r4), r12
	mov.w	r12, -2(r4)
	jmp	.LBB59_5
.LBB59_5:                               ; %if.end
	;DEBUG_VALUE: msp_reseter_auto_rand:interval <- [%FP+-2]
	jmp	.LBB59_6
.LBB59_6:                               ; %if.end8
	;DEBUG_VALUE: msp_reseter_auto_rand:interval <- [%FP+-2]
	mov.w	&noise_idx, r12
	add.w	#1, r12
	mov.w	r12, &noise_idx
	cmp.w	#200, r12
	jne	.LBB59_8
	jmp	.LBB59_7
.LBB59_7:                               ; %if.then11
	;DEBUG_VALUE: msp_reseter_auto_rand:interval <- [%FP+-2]
	mov.w	#0, &noise_idx
	jmp	.LBB59_8
.LBB59_8:                               ; %if.end12
	;DEBUG_VALUE: msp_reseter_auto_rand:interval <- [%FP+-2]
	mov.w	-2(r4), r12
	and.w	#-2, r12
	mov.w	r12, r15
	call	#msp_reseter_auto
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end59:
	.size	msp_reseter_auto_rand, .Lfunc_end59-msp_reseter_auto_rand

	.globl	calculate_interval
	.align	2
	.type	calculate_interval,@function
calculate_interval:                     ; @calculate_interval
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	sub.w	#64, r1
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	r13, r12
	mov.w	r14, r11
	mov.w	r15, r10
	mov.w	r15, -8(r4)
	mov.w	r14, -10(r4)
	mov.w	r13, -12(r4)
	mov.w	#.Lcalculate_interval.current_matrix, r14
	mov.w	r4, r15
	sub.w	#52, r15
	mov.w	#40, r13
	mov.w	r12, -62(r4)            ; 2-byte Folded Spill
	mov.w	r11, -64(r4)            ; 2-byte Folded Spill
	mov.w	r10, -66(r4)            ; 2-byte Folded Spill
	call	#memcpy
	mov.w	-8(r4), r12
	cmp.w	#4, r12
	jhs	.LBB60_2
	jmp	.LBB60_1
.LBB60_1:                               ; %if.then
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	#0, -54(r4)
	jmp	.LBB60_12
.LBB60_2:                               ; %if.else
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	-8(r4), r12
	cmp.w	#8, r12
	jhs	.LBB60_4
	jmp	.LBB60_3
.LBB60_3:                               ; %if.then2
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	#1, -54(r4)
	jmp	.LBB60_11
.LBB60_4:                               ; %if.else3
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	-8(r4), r12
	cmp.w	#16, r12
	jhs	.LBB60_6
	jmp	.LBB60_5
.LBB60_5:                               ; %if.then5
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	#2, -54(r4)
	jmp	.LBB60_10
.LBB60_6:                               ; %if.else6
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	-8(r4), r12
	cmp.w	#16, r12
	jne	.LBB60_8
	jmp	.LBB60_7
.LBB60_7:                               ; %if.then8
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	#3, -54(r4)
	jmp	.LBB60_9
.LBB60_8:                               ; %if.else9
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	#-1, -6(r4)
	jmp	.LBB60_28
.LBB60_9:                               ; %if.end
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	jmp	.LBB60_10
.LBB60_10:                              ; %if.end10
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	jmp	.LBB60_11
.LBB60_11:                              ; %if.end11
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	jmp	.LBB60_12
.LBB60_12:                              ; %if.end12
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	-10(r4), r12
	cmp.w	#50, r12
	jhs	.LBB60_14
	jmp	.LBB60_13
.LBB60_13:                              ; %if.then14
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	#0, -56(r4)
	jmp	.LBB60_27
.LBB60_14:                              ; %if.else15
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	-10(r4), r12
	cmp.w	#66, r12
	jhs	.LBB60_16
	jmp	.LBB60_15
.LBB60_15:                              ; %if.then17
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	#1, -56(r4)
	jmp	.LBB60_26
.LBB60_16:                              ; %if.else18
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	-10(r4), r12
	cmp.w	#75, r12
	jhs	.LBB60_18
	jmp	.LBB60_17
.LBB60_17:                              ; %if.then20
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	#2, -56(r4)
	jmp	.LBB60_25
.LBB60_18:                              ; %if.else21
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	-10(r4), r12
	cmp.w	#100, r12
	jhs	.LBB60_20
	jmp	.LBB60_19
.LBB60_19:                              ; %if.then23
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	#3, -56(r4)
	jmp	.LBB60_24
.LBB60_20:                              ; %if.else24
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	mov.w	-10(r4), r12
	cmp.w	#100, r12
	jne	.LBB60_22
	jmp	.LBB60_21
.LBB60_21:                              ; %if.then26
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	#4, -56(r4)
	jmp	.LBB60_23
.LBB60_22:                              ; %if.else27
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	#-1, -6(r4)
	jmp	.LBB60_28
.LBB60_23:                              ; %if.end28
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	jmp	.LBB60_24
.LBB60_24:                              ; %if.end29
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	jmp	.LBB60_25
.LBB60_25:                              ; %if.end30
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	jmp	.LBB60_26
.LBB60_26:                              ; %if.end31
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	jmp	.LBB60_27
.LBB60_27:                              ; %if.end32
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:current <- [%FP+-54]
	mov.w	-56(r4), r12
	rla.w	r12
	rla.w	r12
	mov.w	-54(r4), r13
	add.w	r13, r12
	rla.w	r12
	mov.w	r4, r13
	sub.w	#52, r13
	add.w	r12, r13
	mov.w	0(r13), r12
	mov.w	r12, -58(r4)
	;DEBUG_VALUE: calculate_interval:dt <- [%FP+-56]
	mov.w	-12(r4), r15
	mov.w	#-14112, r14
	mov.w	r12, -68(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-68(r4), r14            ; 2-byte Folded Reload
	call	#__udivhi3
	mov.w	r15, -60(r4)
	mov.w	-8(r4), r14
	call	#__udivhi3
	mov.w	r15, -6(r4)
	jmp	.LBB60_28
.LBB60_28:                              ; %return
	;DEBUG_VALUE: calculate_interval:capacitance <- [%FP+-8]
	;DEBUG_VALUE: calculate_interval:hit_to_miss_ratio <- [%FP+-6]
	;DEBUG_VALUE: calculate_interval:clock_freq <- [%FP+-4]
	mov.w	-6(r4), r15
	add.w	#64, r1
	pop.w	r10
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end60:
	.size	calculate_interval, .Lfunc_end60-calculate_interval

	.globl	msp_uart_init_8mhz
	.align	2
	.type	msp_uart_init_8mhz,@function
msp_uart_init_8mhz:                     ; @msp_uart_init_8mhz
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	&PASEL1_H, r12
	bis.w	#3, r12
	mov.b	r12, r13
	mov.b	r13, &PASEL1_H
	mov.b	&PASEL0_H, r12
	and.w	#252, r12
	mov.b	r12, r13
	mov.b	r13, &PASEL0_H
	mov.w	#1, &UCA0CTLW0
	mov.w	&UCA0CTLW0, r12
	bis.w	#128, r12
	mov.w	r12, &UCA0CTLW0
	mov.b	#4, &UCA0BRW_L
	mov.w	#21761, &UCA0MCTLW
	mov.b	#0, &UCA0BRW_H
	mov.b	&UCA0CTLW0_L, r12
	and.w	#254, r12
	mov.b	r12, r13
	mov.b	r13, &UCA0CTLW0_L
	pop.w	r4
	ret
.Lfunc_end61:
	.size	msp_uart_init_8mhz, .Lfunc_end61-msp_uart_init_8mhz

	.globl	msp_uart_init
	.align	2
	.type	msp_uart_init,@function
msp_uart_init:                          ; @msp_uart_init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	&PASEL1_H, r12
	bis.w	#3, r12
	mov.b	r12, r13
	mov.b	r13, &PASEL1_H
	mov.b	&PASEL0_H, r12
	and.w	#252, r12
	mov.b	r12, r13
	mov.b	r13, &PASEL0_H
	mov.w	#1, &UCA0CTLW0
	mov.w	&UCA0CTLW0, r12
	bis.w	#128, r12
	mov.w	r12, &UCA0CTLW0
	mov.b	#8, &UCA0BRW_L
	mov.w	&UCA0MCTLW, r12
	bis.w	#-10752, r12
	mov.w	r12, &UCA0MCTLW
	mov.b	#0, &UCA0BRW_H
	mov.b	&UCA0CTLW0_L, r12
	and.w	#254, r12
	mov.b	r12, r13
	mov.b	r13, &UCA0CTLW0_L
	pop.w	r4
	ret
.Lfunc_end62:
	.size	msp_uart_init, .Lfunc_end62-msp_uart_init

	.globl	msp_printf
	.align	2
	.type	msp_printf,@function
msp_printf:                             ; @msp_printf
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#44, r1
	;DEBUG_VALUE: msp_printf:format <- [%FP+-4]
	mov.w	4(r4), r12
	mov.w	r12, -4(r4)
	mov.w	r4, r12
	add.w	#6, r12
	mov.w	r12, -18(r4)
	jmp	.LBB63_1
.LBB63_1:                               ; %while.cond
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB63_4 Depth 2
	mov.w	-4(r4), r12
	mov.w	r12, r13
	add.w	#1, r13
	mov.w	r13, -4(r4)
	mov.b	0(r12), r14
	mov.b	r14, -5(r4)
	cmp.b	#0, r14
	jne	4
	br	#.LBB63_40
	jmp	.LBB63_2
.LBB63_2:                               ; %while.body
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.b	-5(r4), r12
	cmp.b	#37, r12
	jeq	4
	br	#.LBB63_37
	jmp	.LBB63_3
.LBB63_3:                               ; %if.then
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	#0, -14(r4)
	jmp	.LBB63_4
.LBB63_4:                               ; %parse_fmt_char
                                        ;   Parent Loop BB63_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov.w	-4(r4), r12
	mov.w	r12, r13
	add.w	#1, r13
	mov.w	r13, -4(r4)
	mov.b	0(r12), r12
	sxt	r12
	mov.b	r12, r14
	mov.b	r14, -5(r4)
	cmp.w	#0, r12
	mov.w	r12, -32(r4)            ; 2-byte Folded Spill
	jne	4
	br	#.LBB63_34
	jmp	.LBB63_5
.LBB63_5:                               ; %parse_fmt_char
                                        ;   in Loop: Header=BB63_4 Depth=2
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	cmp.w	#48, r12
	jne	4
	br	#.LBB63_33
	jmp	.LBB63_6
.LBB63_6:                               ; %parse_fmt_char
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	cmp.w	#99, r12
	jeq	.LBB63_14
	jmp	.LBB63_7
.LBB63_7:                               ; %parse_fmt_char
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	cmp.w	#105, r12
	jeq	.LBB63_15
	jmp	.LBB63_8
.LBB63_8:                               ; %parse_fmt_char
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	cmp.w	#108, r12
	jeq	.LBB63_19
	jmp	.LBB63_9
.LBB63_9:                               ; %parse_fmt_char
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	cmp.w	#110, r12
	jeq	.LBB63_19
	jmp	.LBB63_10
.LBB63_10:                              ; %parse_fmt_char
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	cmp.w	#115, r12
	jeq	.LBB63_13
	jmp	.LBB63_11
.LBB63_11:                              ; %parse_fmt_char
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	cmp.w	#117, r12
	jeq	.LBB63_15
	jmp	.LBB63_12
.LBB63_12:                              ; %parse_fmt_char
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	cmp.w	#120, r12
	jeq	.LBB63_23
	br	#.LBB63_35
.LBB63_13:                              ; %sw.bb
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-18(r4), r12
	add.w	#1, r12
	and.w	#-2, r12
	mov.w	r12, r13
	add.w	#2, r13
	mov.w	r13, -18(r4)
	mov.w	0(r12), r12
	mov.w	r12, -20(r4)
	mov.w	r12, r15
	call	#msp_io_puts_no_newline
	mov.w	r15, -34(r4)            ; 2-byte Folded Spill
	br	#.LBB63_36
.LBB63_14:                              ; %sw.bb5
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-18(r4), r12
	add.w	#1, r12
	and.w	#-2, r12
	mov.w	r12, r13
	add.w	#2, r13
	mov.w	r13, -18(r4)
	mov.w	0(r12), r12
	mov.w	r12, -22(r4)
	mov.w	r12, r15
	call	#msp_io_putchar
	mov.w	r15, -36(r4)            ; 2-byte Folded Spill
	jmp	.LBB63_36
.LBB63_15:                              ; %sw.bb8
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-18(r4), r12
	add.w	#1, r12
	and.w	#-2, r12
	mov.w	r12, r13
	add.w	#2, r13
	mov.w	r13, -18(r4)
	mov.w	0(r12), r12
	mov.w	r12, -24(r4)
	mov.w	r12, -8(r4)
	mov.b	-5(r4), r14
	cmp.b	#105, r14
	jne	.LBB63_18
	jmp	.LBB63_16
.LBB63_16:                              ; %land.lhs.true
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-8(r4), r12
	cmp.w	#0, r12
	jge	.LBB63_18
	jmp	.LBB63_17
.LBB63_17:                              ; %if.then15
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-8(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	mov.w	#45, r15
	call	#msp_io_putchar
	mov.w	r15, -38(r4)            ; 2-byte Folded Spill
	jmp	.LBB63_18
.LBB63_18:                              ; %if.end
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-8(r4), r14
	mov.w	#20, r12
	add.w	#dv, r12
	mov.w	#0, r15
	mov.w	r12, r13
	call	#msp_xtoa
	jmp	.LBB63_36
.LBB63_19:                              ; %sw.bb18
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-18(r4), r12
	add.w	#1, r12
	and.w	#-2, r12
	mov.w	r12, r13
	add.w	#2, r13
	mov.w	r13, -18(r4)
	mov.w	0(r12), r12
	mov.w	-18(r4), r13
	mov.w	r13, r14
	add.w	#2, r14
	mov.w	r14, -18(r4)
	mov.w	0(r13), r13
	mov.w	r13, -26(r4)
	mov.w	r12, -28(r4)
	mov.w	r13, -10(r4)
	mov.w	r12, -12(r4)
	mov.b	-5(r4), r15
	cmp.b	#108, r15
	jne	.LBB63_22
	jmp	.LBB63_20
.LBB63_20:                              ; %land.lhs.true23
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-10(r4), r12
	cmp.w	#0, r12
	jge	.LBB63_22
	jmp	.LBB63_21
.LBB63_21:                              ; %if.then26
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-12(r4), r12
	mov.w	-10(r4), r13
	mov.w	#0, r14
	mov.w	r14, r15
	sub.w	r12, r15
	subc.w	r13, r14
	mov.w	r14, -10(r4)
	mov.w	r15, -12(r4)
	mov.w	#45, r15
	call	#msp_io_putchar
	mov.w	r15, -40(r4)            ; 2-byte Folded Spill
	jmp	.LBB63_22
.LBB63_22:                              ; %if.end29
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-10(r4), r15
	mov.w	-12(r4), r14
	mov.w	#dv, r13
	call	#msp_xtoa
	jmp	.LBB63_36
.LBB63_23:                              ; %sw.bb30
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-18(r4), r12
	add.w	#1, r12
	and.w	#-2, r12
	mov.w	r12, r13
	add.w	#2, r13
	mov.w	r13, -18(r4)
	mov.w	0(r12), r12
	mov.w	r12, -30(r4)
	mov.w	r12, -8(r4)
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	mov.w	r12, -16(r4)
	cmp.w	#0, r12
	jne	.LBB63_25
	jmp	.LBB63_24
.LBB63_24:                              ; %lor.lhs.false
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-14(r4), r12
	cmp.w	#4, r12
	jl	.LBB63_26
	jmp	.LBB63_25
.LBB63_25:                              ; %if.then36
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-16(r4), r15
	call	#msp_puth
	jmp	.LBB63_26
.LBB63_26:                              ; %if.end37
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-8(r4), r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	mov.w	r12, -16(r4)
	cmp.w	#0, r12
	jne	.LBB63_28
	jmp	.LBB63_27
.LBB63_27:                              ; %lor.lhs.false41
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-14(r4), r12
	cmp.w	#3, r12
	jl	.LBB63_29
	jmp	.LBB63_28
.LBB63_28:                              ; %if.then44
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-16(r4), r15
	call	#msp_puth
	jmp	.LBB63_29
.LBB63_29:                              ; %if.end45
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-8(r4), r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	rra.w	r12
	mov.w	r12, -16(r4)
	cmp.w	#0, r12
	jne	.LBB63_31
	jmp	.LBB63_30
.LBB63_30:                              ; %lor.lhs.false49
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-14(r4), r12
	cmp.w	#2, r12
	jl	.LBB63_32
	jmp	.LBB63_31
.LBB63_31:                              ; %if.then52
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-16(r4), r15
	call	#msp_puth
	jmp	.LBB63_32
.LBB63_32:                              ; %if.end53
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.w	-8(r4), r15
	call	#msp_puth
	jmp	.LBB63_36
.LBB63_33:                              ; %sw.bb54
                                        ;   in Loop: Header=BB63_4 Depth=2
	mov.w	-4(r4), r12
	mov.w	r12, r13
	add.w	#1, r13
	mov.w	r13, -4(r4)
	mov.b	0(r12), r14
	mov.b	r14, -5(r4)
	mov.b	-5(r4), r12
	sxt	r12
	add.w	#-48, r12
	mov.w	r12, -14(r4)
	br	#.LBB63_4
.LBB63_34:                              ; %sw.bb58
	mov.w	#0, -2(r4)
	jmp	.LBB63_41
.LBB63_35:                              ; %sw.default
                                        ;   in Loop: Header=BB63_1 Depth=1
	jmp	.LBB63_38
.LBB63_36:                              ; %sw.epilog
                                        ;   in Loop: Header=BB63_1 Depth=1
	jmp	.LBB63_39
.LBB63_37:                              ; %if.else
                                        ;   in Loop: Header=BB63_1 Depth=1
	jmp	.LBB63_38
.LBB63_38:                              ; %bad_fmt
                                        ;   in Loop: Header=BB63_1 Depth=1
	mov.b	-5(r4), r12
	sxt	r12
	mov.w	r12, r15
	call	#msp_io_putchar
	mov.w	r15, -42(r4)            ; 2-byte Folded Spill
	jmp	.LBB63_39
.LBB63_39:                              ; %if.end61
                                        ;   in Loop: Header=BB63_1 Depth=1
	br	#.LBB63_1
.LBB63_40:                              ; %while.end
	mov.w	#0, -2(r4)
	jmp	.LBB63_41
.LBB63_41:                              ; %return
	mov.w	-2(r4), r15
	add.w	#44, r1
	pop.w	r4
	ret
.Lfunc_end63:
	.size	msp_printf, .Lfunc_end63-msp_printf

	.align	2
	.type	msp_io_puts_no_newline,@function
msp_io_puts_no_newline:                 ; @msp_io_puts_no_newline
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	;DEBUG_VALUE: msp_io_puts_no_newline:ptr <- [%FP+-2]
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.w	#0, -4(r4)
	mov.w	-2(r4), r15
	mov.w	r15, -6(r4)
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	jmp	.LBB64_1
.LBB64_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-6(r4), r12
	mov.w	r12, r13
	add.w	#1, r13
	mov.w	r13, -6(r4)
	mov.b	0(r12), r14
	cmp.b	#0, r14
	jeq	.LBB64_3
	jmp	.LBB64_2
.LBB64_2:                               ; %while.body
                                        ;   in Loop: Header=BB64_1 Depth=1
	mov.w	-4(r4), r12
	add.w	#1, r12
	mov.w	r12, -4(r4)
	jmp	.LBB64_1
.LBB64_3:                               ; %while.end
	jmp	.LBB64_4
.LBB64_4:                               ; %while.cond2
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB64_6 Depth 2
	mov.w	-4(r4), r12
	mov.w	r12, r13
	add.w	#-1, r13
	mov.w	r13, -4(r4)
	cmp.w	#0, r12
	jeq	.LBB64_9
	jmp	.LBB64_5
.LBB64_5:                               ; %while.body3
                                        ;   in Loop: Header=BB64_4 Depth=1
	jmp	.LBB64_6
.LBB64_6:                               ; %while.cond4
                                        ;   Parent Loop BB64_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB64_8
	jmp	.LBB64_7
.LBB64_7:                               ; %while.body6
                                        ;   in Loop: Header=BB64_6 Depth=2
	jmp	.LBB64_6
.LBB64_8:                               ; %while.end7
                                        ;   in Loop: Header=BB64_4 Depth=1
	mov.w	-2(r4), r12
	mov.b	0(r12), r12
	mov.w	r12, &UCA0TXBUF
	mov.w	-2(r4), r12
	add.w	#1, r12
	mov.w	r12, -2(r4)
	jmp	.LBB64_4
.LBB64_9:                               ; %while.end10
	mov.w	-4(r4), r15
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end64:
	.size	msp_io_puts_no_newline, .Lfunc_end64-msp_io_puts_no_newline

	.align	2
	.type	msp_io_putchar,@function
msp_io_putchar:                         ; @msp_io_putchar
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#6, r1
	;DEBUG_VALUE: msp_io_putchar:c <- [%FP+-2]
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	mov.b	-2(r4), r13
	mov.b	r13, -3(r4)
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	jmp	.LBB65_1
.LBB65_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	&UCA0IFG, r12
	bit.w	#2, r12
	jne	.LBB65_3
	jmp	.LBB65_2
.LBB65_2:                               ; %while.body
                                        ;   in Loop: Header=BB65_1 Depth=1
	jmp	.LBB65_1
.LBB65_3:                               ; %while.end
	mov.b	-3(r4), r12
	mov.w	r12, &UCA0TXBUF
	mov.w	-2(r4), r15
	add.w	#6, r1
	pop.w	r4
	ret
.Lfunc_end65:
	.size	msp_io_putchar, .Lfunc_end65-msp_io_putchar

	.align	2
	.type	msp_xtoa,@function
msp_xtoa:                               ; @msp_xtoa
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	push.w	r9
	sub.w	#34, r1
	;DEBUG_VALUE: msp_xtoa:x <- [%FP+-6]
	;DEBUG_VALUE: msp_xtoa:dp <- [%FP+-8]
	mov.w	r15, r12
	mov.w	r14, r11
	mov.w	r13, r10
	mov.w	r15, -10(r4)
	mov.w	r14, -12(r4)
	mov.w	r13, -14(r4)
	mov.w	-10(r4), r13
	mov.w	-12(r4), r14
	bis.w	r13, r14
	cmp.w	#0, r14
	mov.w	r12, -22(r4)            ; 2-byte Folded Spill
	mov.w	r10, -24(r4)            ; 2-byte Folded Spill
	mov.w	r11, -26(r4)            ; 2-byte Folded Spill
	jeq	.LBB66_15
	jmp	.LBB66_1
.LBB66_1:                               ; %if.then
	;DEBUG_VALUE: msp_xtoa:dp <- [%FP+-8]
	;DEBUG_VALUE: msp_xtoa:x <- [%FP+-6]
	jmp	.LBB66_2
.LBB66_2:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-12(r4), r12
	mov.w	-10(r4), r13
	mov.w	-14(r4), r14
	mov.w	0(r14), r15
	mov.w	2(r14), r14
	cmp.w	r14, r13
	mov.w	r2, r11
	and.w	#1, r11
	cmp.w	r15, r12
	mov.w	r2, r12
	and.w	#1, r12
	cmp.w	r14, r13
	mov.w	r11, -28(r4)            ; 2-byte Folded Spill
	mov.w	r12, -30(r4)            ; 2-byte Folded Spill
	jeq	.LBB66_4
; BB#3:                                 ; %while.cond
                                        ;   in Loop: Header=BB66_2 Depth=1
	mov.w	-28(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -30(r4)            ; 2-byte Folded Spill
.LBB66_4:                               ; %while.cond
                                        ;   in Loop: Header=BB66_2 Depth=1
	mov.w	-30(r4), r12            ; 2-byte Folded Reload
	bit.w	#1, r12
	jne	.LBB66_6
	jmp	.LBB66_5
.LBB66_5:                               ; %while.body
                                        ;   in Loop: Header=BB66_2 Depth=1
	mov.w	-14(r4), r12
	add.w	#4, r12
	mov.w	r12, -14(r4)
	jmp	.LBB66_2
.LBB66_6:                               ; %while.end
	jmp	.LBB66_7
.LBB66_7:                               ; %do.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB66_8 Depth 2
	mov.w	-14(r4), r12
	mov.w	r12, r13
	add.w	#4, r13
	mov.w	r13, -14(r4)
	mov.w	0(r12), r13
	mov.w	2(r12), r12
	mov.w	r12, -18(r4)
	mov.w	r13, -20(r4)
	mov.b	#48, -15(r4)
	jmp	.LBB66_8
.LBB66_8:                               ; %while.cond2
                                        ;   Parent Loop BB66_7 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov.w	-12(r4), r12
	mov.w	-10(r4), r13
	mov.w	-20(r4), r14
	mov.w	-18(r4), r15
	cmp.w	r15, r13
	mov.w	r2, r11
	mov.w	#1, r10
	mov.w	r10, r9
	bic.w	r11, r9
	cmp.w	r14, r12
	mov.w	r2, r12
	bic.w	r12, r10
	cmp.w	r15, r13
	mov.w	r9, -32(r4)             ; 2-byte Folded Spill
	mov.w	r10, -34(r4)            ; 2-byte Folded Spill
	jeq	.LBB66_10
; BB#9:                                 ; %while.cond2
                                        ;   in Loop: Header=BB66_8 Depth=2
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -34(r4)            ; 2-byte Folded Spill
.LBB66_10:                              ; %while.cond2
                                        ;   in Loop: Header=BB66_8 Depth=2
	mov.w	-34(r4), r12            ; 2-byte Folded Reload
	bit.w	#1, r12
	jne	.LBB66_12
	jmp	.LBB66_11
.LBB66_11:                              ; %while.body4
                                        ;   in Loop: Header=BB66_8 Depth=2
	mov.b	-15(r4), r12
	add.b	#1, r12
	mov.b	r12, -15(r4)
	mov.w	-20(r4), r13
	mov.w	-18(r4), r14
	mov.w	-12(r4), r15
	mov.w	-10(r4), r11
	sub.w	r13, r15
	subc.w	r14, r11
	mov.w	r11, -10(r4)
	mov.w	r15, -12(r4)
	jmp	.LBB66_8
.LBB66_12:                              ; %while.end5
                                        ;   in Loop: Header=BB66_7 Depth=1
	mov.b	-15(r4), r12
	sxt	r12
	mov.w	r12, r15
	call	#msp_io_putchar
	mov.w	r15, -36(r4)            ; 2-byte Folded Spill
	jmp	.LBB66_13
.LBB66_13:                              ; %do.cond
                                        ;   in Loop: Header=BB66_7 Depth=1
	mov.b	-20(r4), r12
	bit.b	#1, r12
	jeq	.LBB66_7
	jmp	.LBB66_14
.LBB66_14:                              ; %do.end
	jmp	.LBB66_16
.LBB66_15:                              ; %if.else
	;DEBUG_VALUE: msp_xtoa:dp <- [%FP+-8]
	;DEBUG_VALUE: msp_xtoa:x <- [%FP+-6]
	mov.w	#48, r15
	call	#msp_io_putchar
	mov.w	r15, -38(r4)            ; 2-byte Folded Spill
	jmp	.LBB66_16
.LBB66_16:                              ; %if.end
	add.w	#34, r1
	pop.w	r9
	pop.w	r10
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end66:
	.size	msp_xtoa, .Lfunc_end66-msp_xtoa

	.align	2
	.type	msp_puth,@function
msp_puth:                               ; @msp_puth
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	;DEBUG_VALUE: msp_puth:n <- [%FP+-2]
	mov.w	r15, r12
	mov.w	r15, -2(r4)
	and.w	#15, r15
	mov.b	msp_puth.hex(r15), r13
	mov.b	r13, -3(r4)
	mov.w	-2(r4), r15
	and.w	#15, r15
	mov.b	msp_puth.hex(r15), r15
	sxt	r15
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
	call	#msp_io_putchar
	mov.w	r15, -8(r4)             ; 2-byte Folded Spill
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end67:
	.size	msp_puth, .Lfunc_end67-msp_puth

	.globl	udivmodhi4
	.align	2
	.type	udivmodhi4,@function
udivmodhi4:                             ; @udivmodhi4
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	sub.w	#20, r1
	;DEBUG_VALUE: udivmodhi4:num <- [%FP+-4]
	;DEBUG_VALUE: udivmodhi4:den <- [%FP+-6]
	;DEBUG_VALUE: udivmodhi4:modwanted <- [%FP+-8]
	mov.w	r13, r12
	mov.w	r14, r11
	mov.w	r15, r10
	mov.w	r15, -8(r4)
	mov.w	r14, -10(r4)
	mov.w	r13, -12(r4)
	mov.w	#1, -14(r4)
	mov.w	#0, -16(r4)
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	mov.w	r11, -20(r4)            ; 2-byte Folded Spill
	mov.w	r10, -22(r4)            ; 2-byte Folded Spill
	jmp	.LBB68_1
.LBB68_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-10(r4), r12
	mov.w	-8(r4), r13
	mov.b	#0, r14
	cmp.w	r13, r12
	mov.b	r14, -23(r4)            ; 1-byte Folded Spill
	jhs	.LBB68_4
	jmp	.LBB68_2
.LBB68_2:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB68_1 Depth=1
	mov.w	-14(r4), r12
	mov.b	#0, r13
	cmp.w	#0, r12
	mov.b	r13, -23(r4)            ; 1-byte Folded Spill
	jeq	.LBB68_4
	jmp	.LBB68_3
.LBB68_3:                               ; %land.rhs
                                        ;   in Loop: Header=BB68_1 Depth=1
	mov.b	-9(r4), r12
	bit.b	#-128, r12
	mov.w	r2, r13
	rra.w	r13
	and.w	#1, r13
	mov.b	r13, r12
	mov.b	r12, -23(r4)            ; 1-byte Folded Spill
	jmp	.LBB68_4
.LBB68_4:                               ; %land.end
                                        ;   in Loop: Header=BB68_1 Depth=1
	mov.b	-23(r4), r12            ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB68_6
	jmp	.LBB68_5
.LBB68_5:                               ; %while.body
                                        ;   in Loop: Header=BB68_1 Depth=1
	mov.w	-10(r4), r12
	rla.w	r12
	mov.w	r12, -10(r4)
	mov.w	-14(r4), r12
	rla.w	r12
	mov.w	r12, -14(r4)
	jmp	.LBB68_1
.LBB68_6:                               ; %while.end
	jmp	.LBB68_7
.LBB68_7:                               ; %while.cond3
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-14(r4), r12
	cmp.w	#0, r12
	jeq	.LBB68_11
	jmp	.LBB68_8
.LBB68_8:                               ; %while.body5
                                        ;   in Loop: Header=BB68_7 Depth=1
	mov.w	-8(r4), r12
	mov.w	-10(r4), r13
	cmp.w	r13, r12
	jlo	.LBB68_10
	jmp	.LBB68_9
.LBB68_9:                               ; %if.then
                                        ;   in Loop: Header=BB68_7 Depth=1
	mov.w	-10(r4), r12
	mov.w	-8(r4), r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	mov.w	-14(r4), r12
	mov.w	-16(r4), r13
	bis.w	r12, r13
	mov.w	r13, -16(r4)
	jmp	.LBB68_10
.LBB68_10:                              ; %if.end
                                        ;   in Loop: Header=BB68_7 Depth=1
	mov.w	-14(r4), r12
	clrc
	rrc.w	r12
	mov.w	r12, -14(r4)
	mov.w	-10(r4), r12
	clrc
	rrc.w	r12
	mov.w	r12, -10(r4)
	jmp	.LBB68_7
.LBB68_11:                              ; %while.end8
	mov.w	-12(r4), r12
	cmp.w	#0, r12
	jeq	.LBB68_13
	jmp	.LBB68_12
.LBB68_12:                              ; %if.then10
	mov.w	-8(r4), r12
	mov.w	r12, -6(r4)
	jmp	.LBB68_14
.LBB68_13:                              ; %if.end11
	mov.w	-16(r4), r12
	mov.w	r12, -6(r4)
	jmp	.LBB68_14
.LBB68_14:                              ; %return
	mov.w	-6(r4), r15
	add.w	#20, r1
	pop.w	r10
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end68:
	.size	udivmodhi4, .Lfunc_end68-udivmodhi4

	.globl	__divhi3
	.align	2
	.type	__divhi3,@function
__divhi3:                               ; @__divhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	;DEBUG_VALUE: __divhi3:a <- [%FP+-2]
	;DEBUG_VALUE: __divhi3:b <- [%FP+-4]
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	mov.w	#0, -6(r4)
	mov.w	-2(r4), r14
	cmp.w	#0, r14
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	jge	.LBB69_2
	jmp	.LBB69_1
.LBB69_1:                               ; %if.then
	;DEBUG_VALUE: __divhi3:b <- [%FP+-4]
	;DEBUG_VALUE: __divhi3:a <- [%FP+-2]
	mov.w	-2(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -2(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	mov.w	r2, r12
	rra.w	r12
	and.w	#1, r12
	mov.w	r12, -6(r4)
	jmp	.LBB69_2
.LBB69_2:                               ; %if.end
	;DEBUG_VALUE: __divhi3:b <- [%FP+-4]
	;DEBUG_VALUE: __divhi3:a <- [%FP+-2]
	mov.w	-4(r4), r12
	cmp.w	#0, r12
	jge	.LBB69_4
	jmp	.LBB69_3
.LBB69_3:                               ; %if.then2
	;DEBUG_VALUE: __divhi3:a <- [%FP+-2]
	;DEBUG_VALUE: __divhi3:b <- [%FP+-4]
	mov.w	-4(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -4(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	mov.w	r2, r12
	rra.w	r12
	and.w	#1, r12
	mov.w	r12, -6(r4)
	jmp	.LBB69_4
.LBB69_4:                               ; %if.end7
	;DEBUG_VALUE: __divhi3:a <- [%FP+-2]
	;DEBUG_VALUE: __divhi3:b <- [%FP+-4]
	mov.w	-2(r4), r15
	mov.w	-4(r4), r14
	mov.w	#0, r13
	call	#udivmodhi4
	mov.w	r15, -8(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	jeq	.LBB69_6
	jmp	.LBB69_5
.LBB69_5:                               ; %if.then9
	;DEBUG_VALUE: __divhi3:b <- [%FP+-4]
	;DEBUG_VALUE: __divhi3:a <- [%FP+-2]
	mov.w	-8(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	jmp	.LBB69_6
.LBB69_6:                               ; %if.end11
	;DEBUG_VALUE: __divhi3:b <- [%FP+-4]
	;DEBUG_VALUE: __divhi3:a <- [%FP+-2]
	mov.w	-8(r4), r15
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end69:
	.size	__divhi3, .Lfunc_end69-__divhi3

	.globl	__modhi3
	.align	2
	.type	__modhi3,@function
__modhi3:                               ; @__modhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	;DEBUG_VALUE: __modhi3:a <- [%FP+-2]
	;DEBUG_VALUE: __modhi3:b <- [%FP+-4]
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	mov.w	#0, -6(r4)
	mov.w	-2(r4), r14
	cmp.w	#0, r14
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	jge	.LBB70_2
	jmp	.LBB70_1
.LBB70_1:                               ; %if.then
	;DEBUG_VALUE: __modhi3:b <- [%FP+-4]
	;DEBUG_VALUE: __modhi3:a <- [%FP+-2]
	mov.w	-2(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -2(r4)
	mov.w	#1, -6(r4)
	jmp	.LBB70_2
.LBB70_2:                               ; %if.end
	;DEBUG_VALUE: __modhi3:b <- [%FP+-4]
	;DEBUG_VALUE: __modhi3:a <- [%FP+-2]
	mov.w	-4(r4), r12
	cmp.w	#0, r12
	jge	.LBB70_4
	jmp	.LBB70_3
.LBB70_3:                               ; %if.then2
	;DEBUG_VALUE: __modhi3:a <- [%FP+-2]
	;DEBUG_VALUE: __modhi3:b <- [%FP+-4]
	mov.w	-4(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -4(r4)
	jmp	.LBB70_4
.LBB70_4:                               ; %if.end4
	;DEBUG_VALUE: __modhi3:a <- [%FP+-2]
	;DEBUG_VALUE: __modhi3:b <- [%FP+-4]
	mov.w	-2(r4), r15
	mov.w	-4(r4), r14
	mov.w	#1, r13
	call	#udivmodhi4
	mov.w	r15, -8(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	jeq	.LBB70_6
	jmp	.LBB70_5
.LBB70_5:                               ; %if.then5
	;DEBUG_VALUE: __modhi3:b <- [%FP+-4]
	;DEBUG_VALUE: __modhi3:a <- [%FP+-2]
	mov.w	-8(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	jmp	.LBB70_6
.LBB70_6:                               ; %if.end7
	;DEBUG_VALUE: __modhi3:b <- [%FP+-4]
	;DEBUG_VALUE: __modhi3:a <- [%FP+-2]
	mov.w	-8(r4), r15
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end70:
	.size	__modhi3, .Lfunc_end70-__modhi3

	.globl	__udivhi3
	.align	2
	.type	__udivhi3,@function
__udivhi3:                              ; @__udivhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#8, r1
	;DEBUG_VALUE: __udivhi3:a <- [%FP+-2]
	;DEBUG_VALUE: __udivhi3:b <- [%FP+-4]
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -4(r4)
	mov.w	r14, -6(r4)
	mov.w	-4(r4), r15
	mov.w	#0, r11
	mov.w	r13, -8(r4)             ; 2-byte Folded Spill
	mov.w	r11, r13
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#udivmodhi4
	add.w	#8, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end71:
	.size	__udivhi3, .Lfunc_end71-__udivhi3

	.globl	__umodhi3
	.align	2
	.type	__umodhi3,@function
__umodhi3:                              ; @__umodhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#8, r1
	;DEBUG_VALUE: __umodhi3:a <- [%FP+-2]
	;DEBUG_VALUE: __umodhi3:b <- [%FP+-4]
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -4(r4)
	mov.w	r14, -6(r4)
	mov.w	-4(r4), r15
	mov.w	#1, r11
	mov.w	r13, -8(r4)             ; 2-byte Folded Spill
	mov.w	r11, r13
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#udivmodhi4
	add.w	#8, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end72:
	.size	__umodhi3, .Lfunc_end72-__umodhi3

	.globl	mult16
	.align	2
	.type	mult16,@function
mult16:                                 ; @mult16
; BB#0:                                 ; %entry
	;APP
	MOV R15, &0x04C0
MOV R14, &0x04C8
MOV &0x04CA, R14
MOV &0x04CC, R15
RET

	;NO_APP
.Lfunc_end73:
	.size	mult16, .Lfunc_end73-mult16

	.globl	sqrt16
	.align	2
	.type	sqrt16,@function
sqrt16:                                 ; @sqrt16
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#30, r1
	;DEBUG_VALUE: sqrt16:x <- [%FP+-6]
	mov.w	r15, r12
	mov.w	r14, r13
	mov.w	r15, -6(r4)
	mov.w	r14, -8(r4)
	mov.w	#-1, -10(r4)
	mov.w	#0, -12(r4)
	mov.w	-10(r4), r14
	clrc
	rrc.w	r14
	mov.w	r14, -14(r4)
	mov.w	#0, -18(r4)
	mov.w	#0, -20(r4)
	mov.w	r13, -22(r4)            ; 2-byte Folded Spill
	mov.w	r12, -24(r4)            ; 2-byte Folded Spill
	jmp	.LBB74_1
.LBB74_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-20(r4), r12
	mov.w	-18(r4), r13
	mov.w	-8(r4), r14
	mov.w	-6(r4), r15
	mov.b	#0, r11
	xor.w	r15, r13
	xor.w	r14, r12
	bis.w	r13, r12
	cmp.w	#0, r12
	mov.b	r11, -25(r4)            ; 1-byte Folded Spill
	jeq	.LBB74_3
	jmp	.LBB74_2
.LBB74_2:                               ; %land.rhs
                                        ;   in Loop: Header=BB74_1 Depth=1
	mov.w	-10(r4), r12
	mov.w	-12(r4), r13
	sub.w	r13, r12
	cmp.w	#2, r12
	mov.w	r2, r12
	and.w	#1, r12
	mov.b	r12, r14
	mov.b	r14, -25(r4)            ; 1-byte Folded Spill
	jmp	.LBB74_3
.LBB74_3:                               ; %land.end
                                        ;   in Loop: Header=BB74_1 Depth=1
	mov.b	-25(r4), r12            ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB74_10
	jmp	.LBB74_4
.LBB74_4:                               ; %while.body
                                        ;   in Loop: Header=BB74_1 Depth=1
	mov.w	-10(r4), r12
	mov.w	-12(r4), r13
	mov.w	#0, r14
	add.w	r13, r12
	addc.w	#0, r14
	clrc
	rrc.w	r12
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	bis.w	r14, r12
	mov.w	r12, -14(r4)
	mov.w	r12, r15
	mov.w	r12, r14
	call	#mult16
	mov.w	r15, -18(r4)
	mov.w	r14, -20(r4)
	mov.w	-8(r4), r12
	mov.w	-6(r4), r13
	cmp.w	r13, r15
	mov.w	r2, r11
	and.w	#1, r11
	cmp.w	r12, r14
	mov.w	r2, r12
	and.w	#1, r12
	cmp.w	r13, r15
	mov.w	r11, -28(r4)            ; 2-byte Folded Spill
	mov.w	r12, -30(r4)            ; 2-byte Folded Spill
	jeq	.LBB74_6
; BB#5:                                 ; %while.body
                                        ;   in Loop: Header=BB74_1 Depth=1
	mov.w	-28(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -30(r4)            ; 2-byte Folded Spill
.LBB74_6:                               ; %while.body
                                        ;   in Loop: Header=BB74_1 Depth=1
	mov.w	-30(r4), r12            ; 2-byte Folded Reload
	bit.w	#1, r12
	jne	.LBB74_8
	jmp	.LBB74_7
.LBB74_7:                               ; %if.then
                                        ;   in Loop: Header=BB74_1 Depth=1
	mov.w	-14(r4), r12
	mov.w	r12, -12(r4)
	jmp	.LBB74_9
.LBB74_8:                               ; %if.else
                                        ;   in Loop: Header=BB74_1 Depth=1
	mov.w	-14(r4), r12
	mov.w	r12, -10(r4)
	jmp	.LBB74_9
.LBB74_9:                               ; %if.end
                                        ;   in Loop: Header=BB74_1 Depth=1
	jmp	.LBB74_1
.LBB74_10:                              ; %while.end
	mov.w	-14(r4), r15
	add.w	#30, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end74:
	.size	sqrt16, .Lfunc_end74-sqrt16

	.type	full_run_started,@object ; @full_run_started
	.section	.nv_vars,"aw",@progbits
	.globl	full_run_started
full_run_started:
	.byte	0                       ; 0x0
	.size	full_run_started, 1

	.type	first_run,@object       ; @first_run
	.globl	first_run
first_run:
	.byte	1                       ; 0x1
	.size	first_run, 1

	.type	__task_init_TW__,@object ; @__task_init_TW__
	.globl	__task_init_TW__
__task_init_TW__:
	.byte	2                       ; 0x2
	.size	__task_init_TW__, 1

	.type	__task_select_func_TW__,@object ; @__task_select_func_TW__
	.globl	__task_select_func_TW__
__task_select_func_TW__:
	.byte	2                       ; 0x2
	.size	__task_select_func_TW__, 1

	.type	__task_bit_count_TW__,@object ; @__task_bit_count_TW__
	.globl	__task_bit_count_TW__
__task_bit_count_TW__:
	.byte	1                       ; 0x1
	.size	__task_bit_count_TW__, 1

	.type	__task_bitcount_TW__,@object ; @__task_bitcount_TW__
	.globl	__task_bitcount_TW__
__task_bitcount_TW__:
	.byte	2                       ; 0x2
	.size	__task_bitcount_TW__, 1

	.type	__task_ntbl_bitcnt_TW__,@object ; @__task_ntbl_bitcnt_TW__
	.globl	__task_ntbl_bitcnt_TW__
__task_ntbl_bitcnt_TW__:
	.byte	1                       ; 0x1
	.size	__task_ntbl_bitcnt_TW__, 1

	.type	__task_ntbl_bitcount_TW__,@object ; @__task_ntbl_bitcount_TW__
	.globl	__task_ntbl_bitcount_TW__
__task_ntbl_bitcount_TW__:
	.byte	2                       ; 0x2
	.size	__task_ntbl_bitcount_TW__, 1

	.type	__task_BW_btbl_bitcount_TW__,@object ; @__task_BW_btbl_bitcount_TW__
	.globl	__task_BW_btbl_bitcount_TW__
__task_BW_btbl_bitcount_TW__:
	.byte	2                       ; 0x2
	.size	__task_BW_btbl_bitcount_TW__, 1

	.type	__task_AR_btbl_bitcount_TW__,@object ; @__task_AR_btbl_bitcount_TW__
	.globl	__task_AR_btbl_bitcount_TW__
__task_AR_btbl_bitcount_TW__:
	.byte	2                       ; 0x2
	.size	__task_AR_btbl_bitcount_TW__, 1

	.type	__task_bit_shifter_TW__,@object ; @__task_bit_shifter_TW__
	.globl	__task_bit_shifter_TW__
__task_bit_shifter_TW__:
	.byte	2                       ; 0x2
	.size	__task_bit_shifter_TW__, 1

	.type	__task_end_TW__,@object ; @__task_end_TW__
	.globl	__task_end_TW__
__task_end_TW__:
	.byte	1                       ; 0x1
	.size	__task_end_TW__, 1

	.type	_v_func,@object         ; @_v_func
	.section	.p_vars,"aw",@progbits
	.globl	_v_func
	.align	1
_v_func:
	.short	0                       ; 0x0
	.size	_v_func, 2

	.type	_v_n_0,@object          ; @_v_n_0
	.globl	_v_n_0
	.align	1
_v_n_0:
	.short	0                       ; 0x0
	.size	_v_n_0, 2

	.type	_v_n_1,@object          ; @_v_n_1
	.globl	_v_n_1
	.align	1
_v_n_1:
	.short	0                       ; 0x0
	.size	_v_n_1, 2

	.type	_v_n_2,@object          ; @_v_n_2
	.globl	_v_n_2
	.align	1
_v_n_2:
	.short	0                       ; 0x0
	.size	_v_n_2, 2

	.type	_v_n_3,@object          ; @_v_n_3
	.globl	_v_n_3
	.align	1
_v_n_3:
	.short	0                       ; 0x0
	.size	_v_n_3, 2

	.type	_v_n_4,@object          ; @_v_n_4
	.globl	_v_n_4
	.align	1
_v_n_4:
	.short	0                       ; 0x0
	.size	_v_n_4, 2

	.type	_v_n_5,@object          ; @_v_n_5
	.globl	_v_n_5
	.align	1
_v_n_5:
	.short	0                       ; 0x0
	.size	_v_n_5, 2

	.type	_v_n_6,@object          ; @_v_n_6
	.globl	_v_n_6
	.align	1
_v_n_6:
	.short	0                       ; 0x0
	.size	_v_n_6, 2

	.type	_v_seed,@object         ; @_v_seed
	.globl	_v_seed
	.align	2
_v_seed:
	.long	0                       ; 0x0
	.size	_v_seed, 4

	.type	_v_iter,@object         ; @_v_iter
	.globl	_v_iter
	.align	1
_v_iter:
	.short	0                       ; 0x0
	.size	_v_iter, 2

	.type	bits,@object            ; @bits
	.section	.nv_vars,"aw",@progbits
bits:
	.ascii	"\000\001\001\002\001\002\002\003\001\002\002\003\002\003\003\004\001\002\002\003\002\003\003\004\002\003\003\004\003\004\004\005\001\002\002\003\002\003\003\004\002\003\003\004\003\004\004\005\002\003\003\004\003\004\004\005\003\004\004\005\004\005\005\006\001\002\002\003\002\003\003\004\002\003\003\004\003\004\004\005\002\003\003\004\003\004\004\005\003\004\004\005\004\005\005\006\002\003\003\004\003\004\004\005\003\004\004\005\004\005\005\006\003\004\004\005\004\005\005\006\004\005\005\006\005\006\006\007\001\002\002\003\002\003\003\004\002\003\003\004\003\004\004\005\002\003\003\004\003\004\004\005\003\004\004\005\004\005\005\006\002\003\003\004\003\004\004\005\003\004\004\005\004\005\005\006\003\004\004\005\004\005\005\006\004\005\005\006\005\006\006\007\002\003\003\004\003\004\004\005\003\004\004\005\004\005\005\006\003\004\004\005\004\005\005\006\004\005\005\006\005\006\006\007\003\004\004\005\004\005\005\006\004\005\005\006\005\006\006\007\004\005\005\006\005\006\006\007\005\006\006\007\006\007\007\b"
	.size	bits, 256

	.type	init_done,@object       ; @init_done
	.globl	init_done
init_done:
	.byte	0                       ; 0x0
	.size	init_done, 1

	.type	store_buf,@object       ; @store_buf
	.globl	store_buf
store_buf:
	.zero	256
	.size	store_buf, 256

	.type	shadow_buf_pages_count,@object ; @shadow_buf_pages_count
	.globl	shadow_buf_pages_count
	.align	1
shadow_buf_pages_count:
	.short	0                       ; 0x0
	.size	shadow_buf_pages_count, 2

	.type	commit_page_idx,@object ; @commit_page_idx
	.globl	commit_page_idx
	.align	1
commit_page_idx:
	.short	0                       ; 0x0
	.size	commit_page_idx, 2

	.type	last_var_pg_tag,@object ; @last_var_pg_tag
	.section	.bss,"aw",@nobits
	.globl	last_var_pg_tag
	.align	1
last_var_pg_tag:
	.short	0                       ; 0x0
	.size	last_var_pg_tag, 2

	.type	last_ram_page_idx,@object ; @last_ram_page_idx
	.globl	last_ram_page_idx
	.align	1
last_ram_page_idx:
	.short	0                       ; 0x0
	.size	last_ram_page_idx, 2

	.type	last_ram_pg_tag,@object ; @last_ram_pg_tag
	.globl	last_ram_pg_tag
	.align	1
last_ram_pg_tag:
	.short	0                       ; 0x0
	.size	last_ram_pg_tag, 2

	.type	swap_index,@object      ; @swap_index
	.globl	swap_index
	.align	1
swap_index:
	.short	0                       ; 0x0
	.size	swap_index, 2

	.type	page_fault_counter,@object ; @page_fault_counter
	.section	.nv_vars,"aw",@progbits
	.globl	page_fault_counter
	.align	1
page_fault_counter:
	.short	0                       ; 0x0
	.size	page_fault_counter, 2

	.type	fullpage_fault_counter,@object ; @fullpage_fault_counter
	.globl	fullpage_fault_counter
	.align	1
fullpage_fault_counter:
	.short	0                       ; 0x0
	.size	fullpage_fault_counter, 2

	.type	ram_pages_buf,@object   ; @ram_pages_buf
	.comm	ram_pages_buf,192,2
	.type	shadow_buf_pages,@object ; @shadow_buf_pages
	.globl	shadow_buf_pages
shadow_buf_pages:
	.zero	256
	.size	shadow_buf_pages, 256

	.type	pe_ccr,@object          ; @pe_ccr
	.globl	pe_ccr
	.align	1
pe_ccr:
	.short	4000                    ; 0xfa0
	.size	pe_ccr, 2

	.type	succ_pe_ccr,@object     ; @succ_pe_ccr
	.globl	succ_pe_ccr
	.align	1
succ_pe_ccr:
	.short	0                       ; 0x0
	.size	succ_pe_ccr, 2

	.type	checkpoint_available,@object ; @checkpoint_available
	.globl	checkpoint_available
checkpoint_available:
	.byte	0                       ; 0x0
	.size	checkpoint_available, 1

	.type	death_count,@object     ; @death_count
	.globl	death_count
death_count:
	.byte	0                       ; 0x0
	.size	death_count, 1

	.type	last_cp_buf,@object     ; @last_cp_buf
	.globl	last_cp_buf
	.align	1
last_cp_buf:
	.short	0                       ; 0x0
	.size	last_cp_buf, 2

	.type	restoring,@object       ; @restoring
	.globl	restoring
restoring:
	.byte	0                       ; 0x0
	.size	restoring, 1

	.type	stack_ptr,@object       ; @stack_ptr
	.globl	stack_ptr
	.align	1
stack_ptr:
	.short	0                       ; 0x0
	.size	stack_ptr, 2

	.type	__vector_timer0_b0,@object ; @__vector_timer0_b0
	.section	__interrupt_vector_timer0_b0,"aw",@progbits
	.globl	__vector_timer0_b0
	.align	1
__vector_timer0_b0:
	.short	Timer0_B0_ISR
	.size	__vector_timer0_b0, 2

	.type	commit_flag,@object     ; @commit_flag
	.section	.nv_vars,"aw",@progbits
	.globl	commit_flag
commit_flag:
	.byte	0                       ; 0x0
	.size	commit_flag, 1

	.type	target_budget,@object   ; @target_budget
	.globl	target_budget
	.align	1
target_budget:
	.short	1                       ; 0x1
	.size	target_budget, 2

	.type	current_budget,@object  ; @current_budget
	.section	.bss,"aw",@nobits
	.globl	current_budget
	.align	1
current_budget:
	.short	0                       ; 0x0
	.size	current_budget, 2

	.type	history,@object         ; @history
	.section	.nv_vars,"aw",@progbits
	.globl	history
	.align	1
history:
	.short	10                      ; 0xa
	.size	history, 2

	.type	decrease_target,@object ; @decrease_target
	.data
	.globl	decrease_target
decrease_target:
	.byte	1                       ; 0x1
	.size	decrease_target, 1

	.type	real_task_addr,@object  ; @real_task_addr
	.comm	real_task_addr,2,2
	.type	previous_history,@object ; @previous_history
	.comm	previous_history,2,2
	.type	next_coalesced_task_addr,@object ; @next_coalesced_task_addr
	.section	.nv_vars,"aw",@progbits
	.globl	next_coalesced_task_addr
	.align	1
next_coalesced_task_addr:
	.short	0
	.size	next_coalesced_task_addr, 2

	.type	coalesced_task_addr,@object ; @coalesced_task_addr
	.globl	coalesced_task_addr
	.align	1
coalesced_task_addr:
	.short	0
	.size	coalesced_task_addr, 2

	.type	next_real_task_addr,@object ; @next_real_task_addr
	.comm	next_real_task_addr,2,2
	.type	real_task_time_wgt,@object ; @real_task_time_wgt
	.comm	real_task_time_wgt,1,1
	.type	next_real_task_time_wgt,@object ; @next_real_task_time_wgt
	.comm	next_real_task_time_wgt,1,1
	.type	coalesced_task_time_wgt,@object ; @coalesced_task_time_wgt
	.globl	coalesced_task_time_wgt
coalesced_task_time_wgt:
	.byte	0                       ; 0x0
	.size	coalesced_task_time_wgt, 1

	.type	next_coalesced_task_time_wgt,@object ; @next_coalesced_task_time_wgt
	.globl	next_coalesced_task_time_wgt
next_coalesced_task_time_wgt:
	.byte	0                       ; 0x0
	.size	next_coalesced_task_time_wgt, 1

	.type	overflow,@object        ; @overflow
	.globl	overflow
	.align	1
overflow:
	.short	0                       ; 0x0
	.size	overflow, 2

	.type	__overflow,@object      ; @__overflow
	.section	.bss,"aw",@nobits
	.globl	__overflow
	.align	1
__overflow:
	.short	0                       ; 0x0
	.size	__overflow, 2

	.type	__vector_timer0_b1,@object ; @__vector_timer0_b1
	.section	__interrupt_vector_timer0_b1,"aw",@progbits
	.globl	__vector_timer0_b1
	.align	1
__vector_timer0_b1:
	.short	TIMER0_B1_ISR
	.size	__vector_timer0_b1, 2

	.type	.L.str,@object          ; @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\n\r"
	.size	.L.str, 3

	.type	noise,@object           ; @noise
	.section	.nv_vars,"aw",@progbits
	.globl	noise
	.align	1
noise:
	.short	4902                    ; 0x1326
	.short	6349                    ; 0x18cd
	.short	9858                    ; 0x2682
	.short	9909                    ; 0x26b5
	.short	8807                    ; 0x2267
	.short	8462                    ; 0x210e
	.short	1552                    ; 0x610
	.short	2480                    ; 0x9b0
	.short	4687                    ; 0x124f
	.short	1196                    ; 0x4ac
	.short	1169                    ; 0x491
	.short	3501                    ; 0xdad
	.short	975                     ; 0x3cf
	.short	3672                    ; 0xe58
	.short	6407                    ; 0x1907
	.short	13139                   ; 0x3353
	.short	10706                   ; 0x29d2
	.short	8680                    ; 0x21e8
	.short	6682                    ; 0x1a1a
	.short	3272                    ; 0xcc8
	.short	1389                    ; 0x56d
	.short	580                     ; 0x244
	.short	635                     ; 0x27b
	.short	358                     ; 0x166
	.short	65424                   ; 0xff90
	.short	1092                    ; 0x444
	.short	6678                    ; 0x1a16
	.short	10321                   ; 0x2851
	.short	13820                   ; 0x35fc
	.short	12895                   ; 0x325f
	.short	8518                    ; 0x2146
	.short	941                     ; 0x3ad
	.short	3749                    ; 0xea5
	.short	3862                    ; 0xf16
	.short	2322                    ; 0x912
	.short	3816                    ; 0xee8
	.short	4626                    ; 0x1212
	.short	314                     ; 0x13a
	.short	2338                    ; 0x922
	.short	11745                   ; 0x2de1
	.short	12905                   ; 0x3269
	.short	9618                    ; 0x2592
	.short	7615                    ; 0x1dbf
	.short	8081                    ; 0x1f91
	.short	1786                    ; 0x6fa
	.short	2403                    ; 0x963
	.short	418                     ; 0x1a2
	.short	1357                    ; 0x54d
	.short	488                     ; 0x1e8
	.short	267                     ; 0x10b
	.short	1218                    ; 0x4c2
	.short	8959                    ; 0x22ff
	.short	8372                    ; 0x20b4
	.short	12723                   ; 0x31b3
	.short	10983                   ; 0x2ae7
	.short	8505                    ; 0x2139
	.short	3081                    ; 0xc09
	.short	529                     ; 0x211
	.short	1590                    ; 0x636
	.short	401                     ; 0x191
	.short	1747                    ; 0x6d3
	.short	30                      ; 0x1e
	.short	1095                    ; 0x447
	.short	3036                    ; 0xbdc
	.short	9037                    ; 0x234d
	.short	10813                   ; 0x2a3d
	.short	12037                   ; 0x2f05
	.short	11870                   ; 0x2e5e
	.short	5373                    ; 0x14fd
	.short	1432                    ; 0x598
	.short	2600                    ; 0xa28
	.short	491                     ; 0x1eb
	.short	63                      ; 0x3f
	.short	4393                    ; 0x1129
	.short	2516                    ; 0x9d4
	.short	4930                    ; 0x1342
	.short	5692                    ; 0x163c
	.short	8640                    ; 0x21c0
	.short	12601                   ; 0x3139
	.short	10963                   ; 0x2ad3
	.short	8817                    ; 0x2271
	.short	2653                    ; 0xa5d
	.short	2955                    ; 0xb8b
	.short	1698                    ; 0x6a2
	.short	3225                    ; 0xc99
	.short	4337                    ; 0x10f1
	.short	2085                    ; 0x825
	.short	3713                    ; 0xe81
	.short	6943                    ; 0x1b1f
	.short	10668                   ; 0x29ac
	.short	9046                    ; 0x2356
	.short	9526                    ; 0x2536
	.short	11439                   ; 0x2caf
	.short	3426                    ; 0xd62
	.short	3815                    ; 0xee7
	.short	3322                    ; 0xcfa
	.short	2170                    ; 0x87a
	.short	370                     ; 0x172
	.short	611                     ; 0x263
	.short	2383                    ; 0x94f
	.short	3123                    ; 0xc33
	.short	5748                    ; 0x1674
	.short	9297                    ; 0x2451
	.short	11205                   ; 0x2bc5
	.short	9600                    ; 0x2580
	.short	10791                   ; 0x2a27
	.short	3446                    ; 0xd76
	.short	2098                    ; 0x832
	.short	3905                    ; 0xf41
	.short	65165                   ; 0xfe8d
	.short	3669                    ; 0xe55
	.short	4033                    ; 0xfc1
	.short	1621                    ; 0x655
	.short	3173                    ; 0xc65
	.short	10830                   ; 0x2a4e
	.short	12377                   ; 0x3059
	.short	9708                    ; 0x25ec
	.short	8354                    ; 0x20a2
	.short	6159                    ; 0x180f
	.short	158                     ; 0x9e
	.short	2645                    ; 0xa55
	.short	4038                    ; 0xfc6
	.short	4873                    ; 0x1309
	.short	4032                    ; 0xfc0
	.short	4494                    ; 0x118e
	.short	3972                    ; 0xf84
	.short	5467                    ; 0x155b
	.short	9276                    ; 0x243c
	.short	13434                   ; 0x347a
	.short	10946                   ; 0x2ac2
	.short	9208                    ; 0x23f8
	.short	1240                    ; 0x4d8
	.short	998                     ; 0x3e6
	.short	2435                    ; 0x983
	.short	530                     ; 0x212
	.short	1271                    ; 0x4f7
	.short	1863                    ; 0x747
	.short	65320                   ; 0xff28
	.short	6729                    ; 0x1a49
	.short	11596                   ; 0x2d4c
	.short	11839                   ; 0x2e3f
	.short	10512                   ; 0x2910
	.short	8079                    ; 0x1f8f
	.short	5279                    ; 0x149f
	.short	3101                    ; 0xc1d
	.short	1249                    ; 0x4e1
	.short	787                     ; 0x313
	.short	3617                    ; 0xe21
	.short	3689                    ; 0xe69
	.short	2109                    ; 0x83d
	.short	4703                    ; 0x125f
	.short	9687                    ; 0x25d7
	.short	10514                   ; 0x2912
	.short	13637                   ; 0x3545
	.short	10716                   ; 0x29dc
	.short	10364                   ; 0x287c
	.short	4374                    ; 0x1116
	.short	1242                    ; 0x4da
	.short	4747                    ; 0x128b
	.short	1995                    ; 0x7cb
	.short	1826                    ; 0x722
	.short	375                     ; 0x177
	.short	117                     ; 0x75
	.short	5431                    ; 0x1537
	.short	11727                   ; 0x2dcf
	.short	11360                   ; 0x2c60
	.short	14366                   ; 0x381e
	.short	11677                   ; 0x2d9d
	.short	3850                    ; 0xf0a
	.short	840                     ; 0x348
	.short	3969                    ; 0xf81
	.short	4431                    ; 0x114f
	.short	2294                    ; 0x8f6
	.short	1179                    ; 0x49b
	.short	1401                    ; 0x579
	.short	3399                    ; 0xd47
	.short	6143                    ; 0x17ff
	.short	9781                    ; 0x2635
	.short	10963                   ; 0x2ad3
	.short	11463                   ; 0x2cc7
	.short	9808                    ; 0x2650
	.short	5645                    ; 0x160d
	.short	4091                    ; 0xffb
	.short	4317                    ; 0x10dd
	.short	10                      ; 0xa
	.short	2148                    ; 0x864
	.short	1088                    ; 0x440
	.short	1216                    ; 0x4c0
	.short	2032                    ; 0x7f0
	.short	10235                   ; 0x27fb
	.short	11867                   ; 0x2e5b
	.short	10742                   ; 0x29f6
	.short	9019                    ; 0x233b
	.short	4288                    ; 0x10c0
	.short	786                     ; 0x312
	.short	459                     ; 0x1cb
	.short	582                     ; 0x246
	.short	65                      ; 0x41
	.short	1537                    ; 0x601
	.short	3619                    ; 0xe23
	.size	noise, 400

	.type	noise_idx,@object       ; @noise_idx
	.globl	noise_idx
	.align	1
noise_idx:
	.short	0                       ; 0x0
	.size	noise_idx, 2

	.type	reset,@object           ; @reset
	.globl	reset
	.align	1
reset:
	.short	1                       ; 0x1
	.size	reset, 2

	.type	__vector_timer0_a0,@object ; @__vector_timer0_a0
	.section	__interrupt_vector_timer0_a0,"aw",@progbits
	.globl	__vector_timer0_a0
	.align	1
__vector_timer0_a0:
	.short	Timer0_A0_ISR
	.size	__vector_timer0_a0, 2

	.type	.Lcalculate_interval.current_matrix,@object ; @calculate_interval.current_matrix
	.section	.rodata,"a",@progbits
	.align	1
.Lcalculate_interval.current_matrix:
	.short	370                     ; 0x172
	.short	1280                    ; 0x500
	.short	2510                    ; 0x9ce
	.short	2650                    ; 0xa5a
	.short	240                     ; 0xf0
	.short	745                     ; 0x2e9
	.short	1440                    ; 0x5a0
	.short	1990                    ; 0x7c6
	.short	200                     ; 0xc8
	.short	560                     ; 0x230
	.short	1070                    ; 0x42e
	.short	1620                    ; 0x654
	.short	170                     ; 0xaa
	.short	480                     ; 0x1e0
	.short	890                     ; 0x37a
	.short	1420                    ; 0x58c
	.short	110                     ; 0x6e
	.short	235                     ; 0xeb
	.short	420                     ; 0x1a4
	.short	730                     ; 0x2da
	.size	.Lcalculate_interval.current_matrix, 40

	.type	dv,@object              ; @dv
	.align	1
dv:
	.long	1000000000              ; 0x3b9aca00
	.long	100000000               ; 0x5f5e100
	.long	10000000                ; 0x989680
	.long	1000000                 ; 0xf4240
	.long	100000                  ; 0x186a0
	.long	10000                   ; 0x2710
	.long	1000                    ; 0x3e8
	.long	100                     ; 0x64
	.long	10                      ; 0xa
	.long	1                       ; 0x1
	.size	dv, 40

	.type	msp_puth.hex,@object    ; @msp_puth.hex
msp_puth.hex:
	.ascii	"0123456789ABCDEF"
	.size	msp_puth.hex, 16


	.globl	__isr_11
	.type	__isr_11,@function
__isr_11 = Timer0_B0_ISR
	.globl	__isr_13
	.type	__isr_13,@function
__isr_13 = TIMER0_B1_ISR
	.globl	__isr_14
	.type	__isr_14,@function
__isr_14 = Timer0_A0_ISR
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.ident	"clang version 3.8.1 (tags/RELEASE_381/final)"
	.section	".note.GNU-stack","",@progbits
