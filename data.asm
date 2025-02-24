.data 
array:   .word 5, 34 ,34, 1, 1
length:  .word 5

.text 
.globl main

main: 
    # n = n - 1
    lw   $t0, length
    addi $t0, $t0, -1    

outer_loop: 
    # Branch if t0 < 0
    bltz $t0, end_sort
    la   $t1, array

    # Store i in $t2
    lw   $t2, length 
    addi $t2, $t2, -1    # t2 = length - 1

inner_loop: 
    # If i == 0, go to next pass
    beqz $t2, next_pass

    # Compute offsets
    sll  $t3, $t2, 2    # i * 4 (byte offset)
    addi $t4, $t3, -4   # Offset for arr[i-1]

    # Get addresses of arr[i] and arr[i-1]
    add  $s0, $t1, $t3
    add  $s1, $t1, $t4
    lw   $t5, 0($s0)    # Load arr[i] into $t5
    lw   $t6, 0($s1)    # Load arr[i-1] into $t6

    # If arr[i] < arr[i-1], swap
    bgt  $t6, $t5, swap 

    # Decrement i
    addi $t2, $t2, -1
    j    inner_loop

swap: 
    sw   $t5, 0($s1)
    sw   $t6, 0($s0)
    addi $t2, $t2, -1   # Decrement after swapping
    j    inner_loop

next_pass:
    addi $t0, $t0, -1
    j    outer_loop

end_sort:
    # Printing the sorted array
    lw   $t2, length 
    addi $t2, $t2, -1 

printing_loop:
    bltz $t2, exit      # If i < 0, exit

    # Load and print element
    sll  $t3, $t2, 2    
    add  $t4, $t1, $t3  
    lw   $a0, 0($t4)    
    li   $v0, 1         
    syscall

    # Decrement i
    addi $t2, $t2, -1
    j    printing_loop

exit:
    li   $v0, 10
    syscall
