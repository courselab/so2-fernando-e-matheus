	/* We don't actually use these function in the example, but
	   they are illustrative of low-level x86_16, and may come in
	handy while working on related programming exercises. */

 /* 
 * lba_to_chs:                                                                                     
 * Uses stack to store the first remainder safely.                                             
 *
 * Input:
 *   %cx = LBA (0-based) 
 * 
 * Output: 
 *   %ch: cylinder 
 *   %dh: head   
 *   %cl: sector
 */

lba_to_chs:

        push %bp
        mov %sp, %bp
        sub $3, %sp

        push %ax
        push %bx
        push %dx
        push %si

        /* Compute track and sector index */
        mov %cx, %ax
        xor %dx, %dx
        mov $18, %si
        div %si            /* %ax = track, %dx = sector index */

        push %dx           /* Save sector index on stack */

        /* Compute cylinder and head */
        mov $2, %si
        xor %dx, %dx
        div %si            /* %ax = cylinder, %dx = head */

        /* mov %al, cylinder */
        /* mov %dl, head */

        mov %al, -3(%bp)                /* save cylinder */
        mov %dl, -2(%bp)                /* save head */

        /* Recover sector index */
            pop %bx            /* %bx = sector index */

        /* sector = sector index + 1, insert cyl high bits */
        mov %bl, %al
        inc %al
        and $0x3F, %al

        /* mov cylinder, %ah */

        mov -3(%bp), %ah                /* get saved cylinder */

        shr $2, %ah
        shl $6, %ah
        or %ah, %al

        /* mov %al, sector */

        mov %al, -1(%bp)                /* save sector */

        pop %si
        pop %dx
        pop %bx
        pop %ax


        movb -3(%bp), %ch
        movb -2(%bp), %dh
        movb -1(%bp), %cl

        mov %bp, %sp
        pop %bp

        ret
