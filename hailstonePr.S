# rewritting hailstone function as quiz practice :
hailstone2: 
    # have a call preserved register to store length : 
    # store n in a call preserved register
    push %rdi
    push %r12
    mov %rdi, %r12 # n = r12
    mov $0, %r13 #length = r13
    # start the while loop : 
loop_start:
    # compare n with 0 : 
    test %r12, %12 
    je hailstone_loop_end 
    add $1, $r13
    # checking if n is even by anding it (using test to check the ) with 1 
    test $1, %r12 
    jnz input_not_even
    # if the input is even we keep going here 
    # divide the number by 2 : shr by 1  
    shr $1, %r12
    jmp loop_start
input_not_even: 
    # if number is not even we do 3*n + 1 
    imul $3, %r12
    add $1, %r12
    jmp hailstone_loop_end
hailstone_loop_end: 
    mov %r13, %rax
    ret

