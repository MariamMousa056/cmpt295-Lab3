.section .note.GNU-stack,""
    .global abs_value
    .global power2
    .global hailstone_length
    .text

# absolute value function : 
abs_value : 
    # checking how in the input compares to 0 : 
    test %rdi, %rdi
    # jump if the input is greater than 0 to 'input_is_pos' to just return input it 
    jge input_is_pos
    # if it doesn't jump, meaning the input is negative, we negate it : 
    neg %rdi 
    # move it to the return register and return it : 
    mov %rdi, %rax
    ret
# if it jumped here, we just move the input to the output register and return : 
input_is_pos: 
    mov %rdi, %rax
    ret


power2:
    # we will be using call preserves registers, so we need to 
    # start by pushing them on the stack : 
    push %r12
    push %r13
    push %r14
    # store our n to a call preserverd register
    mov %rdi, %r12
    # have a counter in a call preserverd register that starts at 0 (so it prints the first 1)
    mov $0, %r13
    # have a register storing the current power of 2
    mov $1, %r14
    # we will start the loop : 
loop_start: 
    # we'll compare our current 'counter' (in r13) value to 'n' (in r12)
    cmp %r12 , %r13
    # if our counter is more than our n, jump to 'end_of_power2:
    ja  end_of_power2
    # otherwise : if our n is less, well call print_uint64 : 
    # first we need to put the value we want to print in rdi (arg1 register)
    mov %r14, %rdi
    # call print
    call print_uint64
    # add r14 to itself : 
    add %r14, %r14
    # add 1 to our counter (r13)
    add $1, %r13
    # jump to the start of the loop
    jmp loop_start
end_of_power2: 
    # were done !
    # pop the registers we have on the stack (in opposite order we pushed them!!!)
    pop %r14
    pop %r13
    pop %r12
    ret

hailstone_length:
    mov $0, %rax
    ret