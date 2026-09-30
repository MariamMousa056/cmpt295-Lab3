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
    # storing lenght (%r12) (with starts at 0) in a call preserverd register
    # storing n (%r13) in a call preserverd function to make sure we don't lose it somehow 
    push %r12
    push %r13
    mov $0, %r12
    mov %rdi, %r13
loop_start2: 
    # checking if n == 1, if it is well jump to the end of the function and return lenght
    cmp $1, %r13
    je end_of_hailstone_length
    # otherwise if n != 1, we add 1 to lenght
    add $1, %r12
    # we check/test if n is even by doing bitwise and; (will set ZF for even numbers): 
    test $1, %r13
    # we will jump to 'num_not_even' if ZF flag is not set 
    jnz num_not_even
    # otherwise if the number is even we keep going, and we divide the number by 2 then go to the top of the loop: 
    shr $1, %r13
    jmp loop_start2

# if n is not even we will do 'n = 3*n + 1' : 
num_not_even : 
    imul $3, %r13
    add $1, %r13
    jmp loop_start2
end_of_hailstone_length: 
    # we put lenght in rax register to return it
    mov %r12, %rax
    # pop all the registers in the stack in opposite order we pushed 
    pop %r13
    pop %r12
    # return! 
    ret