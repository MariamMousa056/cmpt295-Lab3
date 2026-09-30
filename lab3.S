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
    mov $0, %rax
    ret

hailstone_length:
    mov $0, %rax
    ret